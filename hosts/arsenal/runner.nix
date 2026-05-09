{
  config,
  lib,
  pkgs,
  ...
}: let
  # These must match between the host user and the container image so that
  # the container process can write to mounted volumes on the host filesystem.
  uid = 62824;
  gid = 62824;
  user = "runner";
  group = "forgejo-runner";

  # Some tools (git, cargo) validate that the passwd entry is well-formed before trusting it.
  emptyPasswordHash = "$6$1ero.LwbisiU.h3D$GGmnmECbPotJoPQ5eoSTD6tTjKnSWZcjHoVTkxFLZP17W9hRi/XkmCiAMOfWruUwy8gMjINrBMNODc7cYEo4K.";

  # Nix config for the image instance the runner uses for jobs.
  # These are necessary so a environment can be made with `nix develop` in the workflow.
  nixConfigFile = pkgs.writeTextDir "/etc/nix/nix.conf" ''
    accept-flake-config = true
    experimental-features = nix-command flakes
  '';

  # The container's /etc: NSS so tools like git can resolve the current uid
  # to a username, a passwd/group entry for the runner user, and CA certs
  # for HTTPS.
  # cp -rL instead of buildEnv directly because the container's /nix is a
  # mount point provided at runtime — symlinks into the build-time store path
  # would be broken inside it.
  imageRoot = pkgs.runCommand "image-root" {} ''
    cp -rL ${pkgs.buildEnv {
      name = "image-root";
      paths = [
        (pkgs.dockerTools.fakeNss.override {
          extraPasswdLines = [
            "${user}:${emptyPasswordHash}:${toString uid}:${toString gid}:runner:/tmp:/bin/bash"
          ];
          extraGroupLines = ["${user}:x:${toString gid}:"];
        })
        pkgs.dockerTools.caCertificates
        nixConfigFile
      ];
      pathsToLink = ["/etc"];
    }}/. $out
  '';

  # Tools mounted into /bin at runtime.
  storeDeps = pkgs.buildEnv {
    name = "store-deps";
    paths = with pkgs; [
      # For `nix develop` and building a reproducible environment.
      nix

      # For executing steps in a workflow file (underlying this just becomes a shell script).
      bash

      # Default utilizies that are necessary for common workflow steps.
      coreutils
      findutils
      gnugrep
      gawk
      gnutar
      gzip

      # Most "actions" are defined in JS/TS and require node to execute (for example @checkout).
      nodejs

      # Required underlying for some actions (for example @checkout).
      git
      openssh

      # A conveniance tool for debugging workflows.
      jq
    ];
    pathsToLink = ["/bin"];
  };

  image = pkgs.dockerTools.buildImage {
    name = "forgejo-nix-runner";
    tag = "latest";

    copyToRoot = [imageRoot];

    runAsRoot = ''
      mkdir -p /tmp
      chown ${toString uid}:${toString gid} /tmp
    '';

    config = {
      Cmd = ["/bin/bash"];
      User = user;
      # Declaring these as Volumes tells podman they are external mount
      # points, provided by the runner at job startup (see container.options).
      Volumes = {
        "/nix" = {};
        "/bin" = {};
      };
      Env = [
        # Tells nix to utilize the injected `bash` for build scripts.
        "NIX_BUILD_SHELL=/bin/bash"

        # Some nix commands pipe their output through pagers like `less`,
        # the issue being that `less` requires key input to continue.
        #
        # Setting the pager as `cat` simply ensures the nix commands won't hang silently.
        "PAGER=cat"

        # Tells the image to look in /bin for binaries.
        "PATH=/bin"

        # Nix containers have no distro-provided cert bundle, so tools like
        # git and curl cannot verify HTTPS certificates unless pointed here
        # explicitly.
        #
        # This is unrelated to runner -> codeberg authentication.
        "SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt"

        # Forward nix commands to the host daemon rather than spinning up
        # a new one inside the container.
        #
        # Works because we use host networking.
        "NIX_REMOTE=daemon"
      ];
    };
  };
in {
  virtualisation.podman.enable = true;

  # Cleans nix/store at regular intervals to ensure build-artifacts from different environments don't fill up.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  age.secrets.arsenal-runner-token = {
    mode = "0444";
    file = ../../secrets/arsenal-runner-token.age;
  };

  # This defines the actual runner instance for the workflows.
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.arsenal = {
      enable = true;
      name = "arsenal";
      url = "https://codeberg.org";

      # For some reason, I need to use the old (depracated) approach where
      # the token file only contains a registration token, which forgejo uses
      # to create a runner from. If I create a runner and use its token in the
      # token file, registration fails - not sure what the issue is to be honest.
      tokenFile = config.age.secrets.arsenal-runner-token.path;

      # Maps the `runs-on: nix` workflow key to this local container image.
      # localhost/ prefix prevents the runner from trying to pull it from a registry.
      labels = ["nix:docker://localhost/${image.imageName}:${image.imageTag}"];

      settings.runner = {
        # Number of jobs that can run concurrently on this runner, before others are queued.
        capacity = 5;

        # Injected into all job containers - avoids repeating in every workflow,
        # this effectively just means that all rust-based workflows share the same
        # local crate registry index and crate cache, which stops each workflow
        # from downloading all crates on each invocation of the job.
        envs.CARGO_HOME = "/opt/ci-cache/cargo-home";
      };

      settings.container = {
        # Host networking is required so the container can reach the nix
        # daemon socket on the host (used via NIX_REMOTE=daemon).
        network = "host";

        # Mounts applied to every job container:
        #   /nix           — host nix store (world-readable, effectively read-only)
        #   /bin           — tools from storeDeps
        #   /opt/ci-cache  — persistent build artifact cache
        options = lib.concatStringsSep " " [
          "-v /nix:/nix"
          "-v ${storeDeps}/bin:/bin"
          "-v /opt/ci-cache:/opt/ci-cache"
        ];

        # Security whitelist — the runner refuses to mount any path not listed here,
        # even if a workflow explicitly requests it.
        valid_volumes = [
          "/nix"
          "${storeDeps}/bin"
          "/opt/ci-cache"
        ];
      };
    };
  };

  # Explicit user so the uid/gid are stable and match what is baked into
  # the container image, ensuring the container process can write to /opt/ci-cache.
  users.users.${group} = {
    uid = uid;
    group = group;
    isSystemUser = true;
    home = "/var/empty";
  };
  users.groups.${group}.gid = gid;

  # Nix-built images are not auto-discovered by podman — they need to be explicitly loaded.
  systemd.services.forgejo-runner-load-image = {
    wantedBy = ["multi-user.target"];
    after = ["podman.service"];
    requires = ["podman.service"];

    path = [config.virtualisation.podman.package];
    script = "podman load < ${image}";

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    restartIfChanged = true;
  };

  # Ensures the cache directory exists with correct ownership on first boot.
  # Data persists naturally; this is just declarative directory provisioning.
  systemd.tmpfiles.rules = [
    "d /opt/ci-cache 0755 ${group} ${group} -"
  ];
}

{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./display.nix
    ./docker.nix
    ./network.nix
    ./nh.nix
    ./security.nix
    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    just
    overskride

    (callPackage ./scripts/dev.nix {})
    (callPackage ./scripts/flash.nix {})
    (callPackage ./scripts/shows.nix {})
  ];
}

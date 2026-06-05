{pkgs, ...}: let
  port = 30000;

  # Where FoundryVTT will store all its data.
  dataDir = "/var/lib/foundryvtt";

  foundryvtt = pkgs.stdenv.mkDerivation {
    name = "foundryvtt";
    src = pkgs.requireFile rec {
      name = "FoundryVTT-Node-14.363.zip";
      sha256 = "sha256-MomSLJobgNlSgOE5r0jWV2slJL62xo2ORyZ7OATjLwY=";
      message = ''
        Download ${name} from https://foundryvtt.com
        and add it to the nix store:
          nix-store --add-fixed sha256 FoundryVTT-Node-<version>.zip

        Compute the sha256 hash:
          nix hash file FoundryVTT-Node-<version>.zip
      '';
    };

    # By default nix will attempt to unpack when pkgs.requireFile is used.
    # However, this archive has no top-level directory, so unpacking fails.
    dontUnpack = true;

    nativeBuildInputs = [pkgs.unzip];
    installPhase = ''
      mkdir -p $out
      unzip $src -d $out
    '';
  };
in {
  # Creating a user for the FoundryVTT instance, just to ensure it doesn't mess with other users etc.
  users.users.foundryvtt = {
    isSystemUser = true;
    group = "foundryvtt";
  };
  users.groups.foundryvtt = {};

  # Service that launches FoundryVTT itself.
  systemd.services.foundryvtt = {
    description = "FoundryVTT";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      User = "foundryvtt";
      Group = "foundryvtt";
      StateDirectory = "foundryvtt";
      ExecStart = "${pkgs.nodejs_24}/bin/node ${foundryvtt}/main.js --dataPath=${dataDir} --port=${toString port}";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
}

{
  config,
  pkgs,
  ...
}: let
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

  # Setup backup to b2 via restic.
  #
  # Restic is what "manages" the backups, not b2 - b2 is just a box that stores everything.
  services.restic.backups = {
    foundryvtt = {
      initialize = true;
      passwordFile = config.age.secrets.b2-password.path;
      repositoryFile = config.age.secrets.b2-bucket.path;
      environmentFile = config.age.secrets.b2-environment.path;

      # When to run the backup.
      timerConfig = {
        OnCalendar = "03:00:00";
        Persistent = true;
      };

      paths = [dataDir];

      # Ensure we keep recent changes, but protect against thing being fucked and not noticing.
      pruneOpts = [
        # Always keep 5 most recent snapshots.
        "--keep-last 5"

        # Keep once per week for 2 weeks.
        "--keep-weekly 2"

        # Keep one per month for 2 months.
        "--keep-monthly 2"

        # Keep one per year for 2 years.
        "--keep-yearly 2"
      ];
    };
  };
}

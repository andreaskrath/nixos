{config, ...}: let
  dataDir = "/var/lib/actual";
in {
  services.actual = {
    enable = true;

    settings = {
      port = 3000;
      dataDir = dataDir;
      allowedLoginMethods = ["password"];
    };
  };

  services.restic.backups = {
    actual = {
      initialize = true;
      passwordFile = config.age.secrets.b2-password.path;
      repositoryFile = config.age.secrets.b2-actual-bucket.path;
      environmentFile = config.age.secrets.b2-actual-environment.path;

      # When to run the backup.
      timerConfig = {
        OnCalendar = "02:00:00";
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

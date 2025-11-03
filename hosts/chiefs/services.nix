{pkgs, ...}: let
  greeter = pkgs.callPackage ./greeter.nix {};
  initiative = pkgs.callPackage ./initiative.nix {};
in {
  systemd.services = {
    greeter = {
      script = "${greeter}/bin/greeter";
      wantedBy = ["multi-user.target"];
    };

    initiative = {
      script = "${initiative}/bin/initiative";
      wantedBy = ["multi-user.target"];
      environment = {
        DB_CONNECTION_STRING = "postgresql://postgres@localhost/dnd?host=/run/postgresql";
      };
    };
  };
}

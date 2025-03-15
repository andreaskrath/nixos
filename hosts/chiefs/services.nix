{pkgs, ...}: let
  greeter = pkgs.callPackage ./greeter.nix {};
in {
  systemd.services.greeter = {
    script = "${greeter}/bin/greeter";
    wantedBy = ["multi-user.target"];
  };
}

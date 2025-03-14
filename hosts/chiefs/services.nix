{pkgs, ...}: let
  greeter = pkgs.callPackage ./greeter.nix {};
in {
  systemd.services.greeter = {
    script = "${greeter}/bin/src";
    wantedBy = ["multi-user.target"];
  };
}

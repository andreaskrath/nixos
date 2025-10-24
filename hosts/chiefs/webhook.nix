{pkgs, ...}: let
  gitPull = pkgs.writeShellApplication {
    name = "script";
    runtimeInputs = with pkgs; [git];
    text = ''
      git pull
    '';
  };
in {
  services.webhook = {
    enable = true;
    user = "mahomes";
    group = "users";

    hooks = {
      recipes = {
        id = "recipes";
        command-working-directory = "/var/recipes";
        execute-command = "${gitPull}/bin/script";
        include-command-output-in-response = true;
      };
    };
  };
}

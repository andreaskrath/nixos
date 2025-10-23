{
  config,
  lib,
  ...
}: let
  cfg = config.krath.home.git;
in {
  options.krath.home.git = {
    enable = lib.mkEnableOption "Enable git module.";

    allowedSignersKey = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = ''
        The SSH key for allowed signers.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      settings = {
        user = {
          name = "Andreas Krath";
          email = "andreas.krath+github@gmail.com";
          signingkey = "~/.ssh/id_ed25519.pub";
        };

        commit.gpgsign = true; # sign all commits using ssh key
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      signing.format = "ssh";
    };

    home.file.".ssh/allowed_signers".text = lib.mkIf (cfg.allowedSignersKey != "") ''
      * ssh-ed25519 ${cfg.allowedSignersKey} andreas.krath+github@gmail.com
    '';
  };
}

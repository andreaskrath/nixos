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
      userName = "Andreas Krath";
      userEmail = "andreas.krath+github@gmail.com";
      signing.format = "ssh";

      extraConfig = {
        commit.gpgsign = true; # sign all commits using ssh key
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };

    home.file.".ssh/allowed_signers".text = lib.mkIf (cfg.allowedSignersKey != "") ''
      * ssh-ed25519 ${cfg.allowedSignersKey} andreas.krath+github@gmail.com
    '';
  };
}

{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.style;
in {
  options.style = {
    enable = lib.mkEnableOption "enable stylix module";

    fontsize = lib.mkOption {
      default = 14;
      description = "font size for applications, terminal, desktop, and popups";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
      polarity = "dark";
      image = ../home/wallpaper.png;

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Classic";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.cascadia-code;
          name = "Cascadia Mono";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "Open Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };

        sizes = {
          applications = cfg.fontsize - 2;
          terminal = cfg.fontsize;
          desktop = cfg.fontsize;
          popups = cfg.fontsize;
        };
      };
    };

    home-manager.users.krath.stylix = {
      targets.helix.enable = false;
    };
  };
}

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

    app-fontsize = lib.mkOption {
      default = 10;
      description = "font size for applications";
    };

    terminal-fontsize = lib.mkOption {
      default = 10;
      description = "font size for terminals";
    };

    desktop-fontsize = lib.mkOption {
      default = 10;
      description = "font size for desktop";
    };

    popup-fontsize = lib.mkOption {
      default = 10;
      description = "font size for popups";
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
          applications = cfg.app-fontsize;
          terminal = cfg.terminal-fontsize;
          desktop = cfg.desktop-fontsize;
          popups = cfg.popup-fontsize;
        };
      };

      targets = {
        grub.enable = false;
      };
    };

    home-manager.users.krath.stylix = {
      targets.helix.enable = false;
      targets.zellij.enable = false;
    };
  };
}

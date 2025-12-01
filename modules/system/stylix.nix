{
  pkgs,
  config,
  lib,
  misc,
  ...
}: let
  cfg = config.krath.system.stylix;
in {
  options.krath.system.stylix = {
    enable = lib.mkEnableOption "Enable stylix module.";

    appFontSize = lib.mkOption {
      type = lib.types.int;
      description = "Font size for applications.";
    };

    terminalFontSize = lib.mkOption {
      type = lib.types.int;
      description = "Font size for terminals.";
    };

    desktopFontSize = lib.mkOption {
      type = lib.types.int;
      description = "Font size for desktop.";
    };

    popupFontSize = lib.mkOption {
      type = lib.types.int;
      description = "Font size for popups.";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      enableReleaseChecks = false;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
      polarity = "dark";
      image = "${misc}/wallpaper.png";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Classic";
        size = 32;
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
          applications = cfg.appFontSize;
          terminal = cfg.terminalFontSize;
          desktop = cfg.desktopFontSize;
          popups = cfg.popupFontSize;
        };
      };

      targets = {
        grub.enable = false;
      };
    };
  };
}

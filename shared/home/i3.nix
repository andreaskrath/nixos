{ pkgs, ... }:
let
  # workspaces
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";
in
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        focus = {
          followMouse = false;
          mouseWarping = false;
        };
        floating.titlebar = false;
        terminal = "alacritty";

        bars = [{
          id = "bar-default";
          command = "${pkgs.i3}/bin/i3bar";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          trayOutput = "primary";
          fonts = {
            names = [ "Cascadia Mono" ];
            style = "Bold";
            size = 12.0;
          };
        }];

        fonts = {
            names = [ "Cascadia Mono" ];
            style = "Bold";
            size = 12.0;
        };

        assigns = {
          "${ws1}" = [{ class = "^Brave-browser$"; } { class = "^brave-browser$"; }];
          "${ws2}" = [{ class = "^Alacritty$"; }];
          "${ws3}" = [{ class = "^code$"; } { class = "^Code$"; }];
          "${ws6}" = [{ class = "^obsidian$"; }];
          "${ws9}" = [{ class = "^discord$"; }];
          "${ws10}" = [{ class = "^spotify$"; }];
        };

        window = {
          border = 0;
          titlebar = false;
        };

        gaps = {
          inner = 15;
          outer = 5;
        };

        keybindings = lib.mkOptionDefault {
          "XF86AudioMute" = "exec amixer set Master toggle";
          "XF86AudioLowerVolume" = "exec amixer set Master 5%-";
          "XF86AudioRaiseVolume" = "exec amixer set Master 5%+";
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
          "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
          "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
          "${modifier}+Shift+s" = "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i";
        };

        startup = [
          {
            command = "${pkgs.feh}/bin/feh --bg-scale /etc/nixos/shared/home/wallpaper.png";
            always = true;
            notification = false;
          }
        ];
      };

      extraConfig = ''
        for_window [class="Spotify"] move to workspace ${ws10}
      '';
    };
  };
}

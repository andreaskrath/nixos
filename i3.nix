{ pkgs, lib, ... }:
let
  # monitors
  m1 = "m1"; # left monitor
  m2 = "m2"; # right monitor
  m1_port = "DP-2";
  m2_port = "DP-4";

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

  # fonts
  fira_code = "Fira Code";
  fira_code_symbols = "Fira Code Symbols";
  font_weight = "Bold";
in
{
  programs.i3status.enable = true;
  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;

    config = rec {
      modifier = "Mod4";
      focus.followMouse = false;
      floating.titlebar = false;
      terminal = "alacritty";

      bars = [{
          id = "bar-default";
          command = "${pkgs.i3}/bin/i3bar";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "${fira_code}" "${fira_code_symbols}" ];
            style = "${font_weight}";
            size = 12.0;
          };
      }];

      fonts = {
        names = [ "${fira_code}" "${fira_code_symbols}" ];
        style = "${font_weight}";
        size = 12.0;
      };

      assigns = {
        "${ws1}" = [ { class = "^Brave-browser$"; } { class = "^brave-browser$"; } ];
        "${ws2}" = [ { class = "^Alacritty$"; } ];
        "${ws3}" = [ { class = "^code$"; } { class = "^Code$"; } ];
        "${ws4}" = [ { class = "^steam$"; } { class = "^Lutris$"; } { class = "^lutris$"; } { class = "^battle.net.exe$"; } ];
        "${ws5}" = [ { class = "^wow.exe$"; } ];
        # "${ws6}" = [{ class = "^brave-browser$"; }];
        # "${ws7}" = [{ class = "^brave-browser$"; }];
        # "${ws8}" = [{ class = "^brave-browser$"; }];
        "${ws9}" = [ { class = "^discord$"; } ];
        "${ws10}" = [ { class = "^spotify$"; } ];
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
        # "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
        # "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";
        "XF86AudioMute" = "exec amixer set Master toggle";
        "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
        "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
        "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${modifier}+b" = "exec ${pkgs.brave}/bin/brave";
      };

      startup = [
        {
          command = "echo dinmor";
          always = true;
          notification = false;
        }
        {
          command = "--no-startup-id ${pkgs.xorg.xrandr}/bin/xrandr --output ${m2_port} --auto --right-of ${m1_port}";
          always = true;
          notification = false;
        }

        # {
        #   command = "${pkgs.feh}/bin/feh --bg-scale ~/background.png";
        #   always = true;
        #   notification = false;
        # }
      ];
    };

    extraConfig = ''
      set $${m1} "DP-2"
      set $${m2} "DP-4"

      workspace ${ws1} output $${m2}
      workspace ${ws2} output $${m2}
      workspace ${ws3} output $${m2}
      workspace ${ws4} output $${m2}
      workspace ${ws5} output $${m2}
      workspace ${ws6} output $${m2}
      workspace ${ws7} output $${m2}
      workspace ${ws8} output $${m2}
      workspace ${ws9} output $${m1}
      workspace ${ws10} output $${m1}

      for_window [class="wow.exe"] move to workspace ${ws5}
      for_window [class="Spotify"] move to workspace ${ws10}
    '';
      # for_window [class="Lutris"] move to workspace ${ws4}
  };
}

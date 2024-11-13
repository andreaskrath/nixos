{pkgs, ...}: let
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
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        defaultWorkspace = "workspace ${ws1}";
        focus = {
          followMouse = false;
          mouseWarping = false;
        };
        floating.titlebar = false;
        terminal = "alacritty";

        bars = [
          {
            id = "bar-default";
            command = "${pkgs.i3}/bin/i3bar";
            statusCommand = "${pkgs.i3status}/bin/i3status";
            trayOutput = "primary";
            fonts = {
              names = ["Cascadia Mono"];
              style = "Bold";
              size = 12.0;
            };
          }
        ];

        assigns = {
          "${ws1}" = [{class = "^Navigator$";} {class = "^firefox$";}];
          "${ws2}" = [{class = "^Alacritty$";}];
          "${ws6}" = [{class = "^obsidian$";}];
          "${ws9}" = [{class = "^vesktop$";}];
          "${ws10}" = [{class = "^spotify$";}];
        };

        window = {
          border = 1;
          titlebar = false;
        };

        gaps = {
          inner = 15;
          outer = 5;
        };

        keybindings = {
          "${modifier}+1" = "workspace ${ws1}";
          "${modifier}+2" = "workspace ${ws2}";
          "${modifier}+3" = "workspace ${ws3}";
          "${modifier}+4" = "workspace ${ws4}";
          "${modifier}+5" = "workspace ${ws5}";
          "${modifier}+6" = "workspace ${ws6}";
          "${modifier}+7" = "workspace ${ws7}";
          "${modifier}+8" = "workspace ${ws8}";
          "${modifier}+9" = "workspace ${ws9}";
          "${modifier}+0" = "workspace ${ws10}";

          "${modifier}+Shift+1" = "move container to workspace ${ws1}";
          "${modifier}+Shift+2" = "move container to workspace ${ws2}";
          "${modifier}+Shift+3" = "move container to workspace ${ws3}";
          "${modifier}+Shift+4" = "move container to workspace ${ws4}";
          "${modifier}+Shift+5" = "move container to workspace ${ws5}";
          "${modifier}+Shift+6" = "move container to workspace ${ws6}";
          "${modifier}+Shift+7" = "move container to workspace ${ws7}";
          "${modifier}+Shift+8" = "move container to workspace ${ws8}";
          "${modifier}+Shift+9" = "move container to workspace ${ws9}";
          "${modifier}+Shift+0" = "move container to workspace ${ws10}";

          "${modifier}+Shift+q" = "kill";

          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+l" = "focus right";

          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";
          "${modifier}+Shift+l" = "move right";

          "${modifier}+v" = "split v";
          "${modifier}+f" = "fullscreen toggle";

          "${modifier}+s" = "layout stacking";
          "${modifier}+w" = "layout tabbed";
          "${modifier}+e" = "layout toggle split";

          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+a" = "focus parent";

          "${modifier}+Shift+minus" = "move scratchpad";
          "${modifier}+minus" = "scratchpad show";

          "${modifier}+Shift+c" = "reload";
          "${modifier}+Shift+r" = "restart";
          "${modifier}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

          "${modifier}+r" = "mode resize";
          "XF86AudioMute" = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
          "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%-";
          "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%+";
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
          "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
          "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";
          "${modifier}+Shift+s" = "exec ${pkgs.maim}/bin/maim -s | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i";
        };
      };

      extraConfig = ''
        for_window [class="Spotify"] move to workspace ${ws10}
      '';
    };
  };
}

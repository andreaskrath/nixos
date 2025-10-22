{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.krath.home.i3;

  bindWorkspaceToOutput = output: workspace: "workspace ${workspace} output ${output}";
in {
  options.krath.home.i3 = {
    enable = lib.mkEnableOption "Enable i3 module.";

    workspace1 = lib.mkOption {
      type = lib.types.str;
      default = "1";
      description = "Workspace 1.";
    };

    workspace2 = lib.mkOption {
      type = lib.types.str;
      default = "2";
      description = "Workspace 2.";
    };

    workspace3 = lib.mkOption {
      type = lib.types.str;
      default = "3";
      description = "Workspace 3.";
    };

    workspace4 = lib.mkOption {
      type = lib.types.str;
      default = "4";
      description = "Workspace 4.";
    };

    workspace5 = lib.mkOption {
      type = lib.types.str;
      default = "5";
      description = "Workspace 5.";
    };

    workspace6 = lib.mkOption {
      type = lib.types.str;
      default = "6";
      description = "Workspace 6.";
    };

    workspace7 = lib.mkOption {
      type = lib.types.str;
      default = "7";
      description = "Workspace 7.";
    };

    workspace8 = lib.mkOption {
      type = lib.types.str;
      default = "8";
      description = "Workspace 8.";
    };

    workspace9 = lib.mkOption {
      type = lib.types.str;
      default = "9";
      description = "Workspace 9.";
    };

    workspace10 = lib.mkOption {
      type = lib.types.str;
      default = "10";
      description = "Workspace 10.";
    };

    extraAssigns = lib.mkOption {
      type = lib.types.attrsOf (
        lib.types.listOf (
          lib.types.attrsOf (
            lib.types.either lib.types.str lib.types.bool
          )
        )
      );
      default = {};
      description = ''
        Extra assignments of application classes to specific workspaces.
      '';
    };

    extraStartup = lib.mkOption {
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            command = lib.mkOption {
              type = lib.types.str;
              description = "Command to execute on startup";
            };
            always = lib.mkOption {
              type = lib.types.bool;
              description = "Whether to run the command on each restart.";
            };
            notification = lib.mkOption {
              type = lib.types.bool;
              description = "Whether to enable startup notifications for this command.";
            };
          };
        }
      );
      default = [];
      description = ''
        Extra startup commands to run.
      '';
    };

    extraKeybinds = lib.mkOption {
      type = lib.types.attrsOf (lib.types.nullOr lib.types.str);
      default = {};
      description = ''
        Extra keybinds to add.
      '';
    };

    bindWorkspaces = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf (lib.types.str));
      default = {};
      description = ''
        Bind specific workspaces to specific outputs.

        The outputs in question should be monitor ports, like DP-1 etc.
      '';
      example = lib.literalExpression ''
        {
          DP-2 = ["1" "2" "3"];
          DP-4 = ["4" "5"];
        }
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    xsession = {
      enable = true;
      windowManager.i3 = {
        enable = true;

        config = rec {
          modifier = "Mod4";
          defaultWorkspace = "workspace ${cfg.workspace1}";
          focus = {
            followMouse = false;
            mouseWarping = false;
          };
          floating.titlebar = false;
          terminal = "alacritty";

          startup =
            [
              {
                command = "systemctl --user restart polybar";
                always = true;
                notification = false;
              }
            ]
            ++ cfg.extraStartup;

          bars = [];

          assigns = lib.mkMerge [
            {
              "${cfg.workspace1}" = [{class = "^Navigator$";} {class = "^Firefox$";} {class = "^firefox$";}];
              "${cfg.workspace2}" = [{class = "^Alacritty$";}];
              "${cfg.workspace6}" = [{class = "^obsidian$";}];
              "${cfg.workspace9}" = [{class = "^discord$";}];
              "${cfg.workspace10}" = [{class = "^spotify$";}];
            }
            cfg.extraAssigns
          ];

          window = {
            border = 1;
            titlebar = false;
          };

          gaps = {
            inner = 15;
            outer = 5;
            top = 40;
          };

          keybindings = lib.mkMerge [
            {
              "${modifier}+1" = "workspace ${cfg.workspace1}";
              "${modifier}+2" = "workspace ${cfg.workspace2}";
              "${modifier}+3" = "workspace ${cfg.workspace3}";
              "${modifier}+4" = "workspace ${cfg.workspace4}";
              "${modifier}+5" = "workspace ${cfg.workspace5}";
              "${modifier}+6" = "workspace ${cfg.workspace6}";
              "${modifier}+7" = "workspace ${cfg.workspace7}";
              "${modifier}+8" = "workspace ${cfg.workspace8}";
              "${modifier}+9" = "workspace ${cfg.workspace9}";
              "${modifier}+0" = "workspace ${cfg.workspace10}";

              "${modifier}+Shift+1" = "move container to workspace ${cfg.workspace1}";
              "${modifier}+Shift+2" = "move container to workspace ${cfg.workspace2}";
              "${modifier}+Shift+3" = "move container to workspace ${cfg.workspace3}";
              "${modifier}+Shift+4" = "move container to workspace ${cfg.workspace4}";
              "${modifier}+Shift+5" = "move container to workspace ${cfg.workspace5}";
              "${modifier}+Shift+6" = "move container to workspace ${cfg.workspace6}";
              "${modifier}+Shift+7" = "move container to workspace ${cfg.workspace7}";
              "${modifier}+Shift+8" = "move container to workspace ${cfg.workspace8}";
              "${modifier}+Shift+9" = "move container to workspace ${cfg.workspace9}";
              "${modifier}+Shift+0" = "move container to workspace ${cfg.workspace10}";

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

              "${modifier}+Control+L" = "exec ${pkgs.i3lock}/bin/i3lock -n -c 000000";

              "${modifier}+r" = "mode resize";
              "XF86AudioMute" = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
              "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%-";
              "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 5%+";
              "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
              "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
              "${modifier}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
              "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";
              "${modifier}+Shift+s" = "exec ${pkgs.maim}/bin/maim -s --hidecursor | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png -i";
              "${modifier}+Shift+x" = ''
                exec ${pkgs.maim}/bin/maim -s --hidecursor /tmp/screenshot.png && \
                ${pkgs.toybox}/bin/mv /tmp/screenshot.png $(${pkgs.zenity}/bin/zenity --file-selection --save --filename="$HOME/Pictures/$(${pkgs.toybox}/bin/date +'%Y-%m-%d-%H%M%S').png")
              '';
            }
            cfg.extraKeybinds
          ];
        };

        extraConfig =
          ''
            for_window [class="Spotify"] move to workspace ${cfg.workspace10}
          ''
          + builtins.concatStringsSep "\n" (
            lib.flatten (
              lib.mapAttrsToList (
                output: workspaces:
                  lib.map (
                    workspace: bindWorkspaceToOutput output workspace
                  )
                  workspaces
              )
              cfg.bindWorkspaces
            )
          );
      };
    };
  };
}

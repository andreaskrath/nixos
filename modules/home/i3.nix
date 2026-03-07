{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.krath.home.i3;

  bindWorkspaceToOutput = output: workspace: "workspace ${workspace} output ${output}";

  workspaces = {
    web = "web";
    code = "code";
    notes = "notes";
    chat = "chat";
    media = "media";
    games = "games";
  };
in {
  options.krath.home.i3 = {
    enable = lib.mkEnableOption "Enable i3 module.";

    enableGames = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the games workspace (Mod+6)";
    };

    ws = lib.mkOption {
      type = lib.types.attrs;
      default = workspaces;
      readOnly = true;
      description = "Workspace names for use in bindWorkspaces, etc.";
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
          defaultWorkspace = "workspace ${workspaces.web}";
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
              "${workspaces.web}" = [{class = "^Navigator$";} {class = "^Firefox$";} {class = "^firefox$";}];
              "${workspaces.code}" = [{class = "^Alacritty$";}];
              "${workspaces.notes}" = [{class = "^obsidian$";}];
              "${workspaces.chat}" = [{class = "^discord$";}];
              "${workspaces.media}" = [{class = "^spotify$";}];
            }
            (lib.mkIf cfg.enableGames {
              "${workspaces.games}" = [{class = "^steam$";} {class = "^Steam$";} {class = "^battle.net.exe$";}];
            })
            cfg.extraAssigns
          ];

          window = {
            border = 1;
            titlebar = false;
            hideEdgeBorders = "smart";
          };

          keybindings = lib.mkMerge [
            {
              "${modifier}+1" = "workspace ${workspaces.web}";
              "${modifier}+2" = "workspace ${workspaces.code}";
              "${modifier}+3" = "workspace ${workspaces.notes}";
              "${modifier}+4" = "workspace ${workspaces.chat}";
              "${modifier}+5" = "workspace ${workspaces.media}";

              "${modifier}+Shift+1" = "move container to workspace ${workspaces.web}";
              "${modifier}+Shift+2" = "move container to workspace ${workspaces.code}";
              "${modifier}+Shift+3" = "move container to workspace ${workspaces.notes}";
              "${modifier}+Shift+4" = "move container to workspace ${workspaces.chat}";
              "${modifier}+Shift+5" = "move container to workspace ${workspaces.media}";
            }
            (lib.mkIf cfg.enableGames {
              "${modifier}+6" = "workspace ${workspaces.games}";
              "${modifier}+Shift+6" = "move container to workspace ${workspaces.games}";
            })
            {
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
            for_window [class="Spotify"] move to workspace ${workspaces.media}
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

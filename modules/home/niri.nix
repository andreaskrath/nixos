{
  config,
  lib,
  pkgs,
  ...
}: let
  LEFT_MONITOR = "DP-2";
  RIGHT_MONITOR = "DP-3";

  ws = {
    web = "web";
    code = "code";
    notes = "notes";
    chat = "chat";
    media = "media";
    games = "games";
  };
in {
  # This is not just a conversion to KDL, but actual options:
  # https://github.com/sodiboo/niri-flake/blob/main/docs.md
  programs.niri.settings = {
    input = {
      keyboard = {
        xkb.layout = "dk";
        numlock = true;
      };
      mouse.accel-speed = 0.0;
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
    };

    xwayland-satellite = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite;
    };

    gestures.hot-corners.enable = false;

    hotkey-overlay.skip-at-startup = true;

    outputs = {
      ${LEFT_MONITOR} = {
        position = {
          x = 0;
          y = 0;
        };
      };
      ${RIGHT_MONITOR} = {
        position = {
          x = 2560;
          y = 0;
        };
        focus-at-startup = true;
      };
    };

    prefer-no-csd = true;

    layout = {
      gaps = 8;
      default-column-width.proportion = 0.5;
      preset-column-widths = [
        {proportion = 0.25;}
        {proportion = 0.33;}
        {proportion = 0.5;}
        {proportion = 0.66;}
        {proportion = 0.75;}
      ];
    };

    workspaces = {
      ${ws.web}.open-on-output = RIGHT_MONITOR;
      ${ws.code}.open-on-output = RIGHT_MONITOR;
      ${ws.notes}.open-on-output = RIGHT_MONITOR;
      ${ws.chat}.open-on-output = LEFT_MONITOR;
      ${ws.media}.open-on-output = LEFT_MONITOR;
      ${ws.games}.open-on-output = RIGHT_MONITOR;
    };

    spawn-at-startup = [
      {command = ["${pkgs.swaybg}/bin/swaybg" "-m" "fill" "-i" "/etc/nixos/misc/wallpaper.png"];}
    ];

    binds = with config.lib.niri.actions; let
      mod = "Mod";
    in {
      # Launch applications
      "${mod}+Return".action = spawn ["${pkgs.alacritty}/bin/alacritty"];
      "${mod}+D".action = spawn ["${pkgs.rofi}/bin/rofi" "-show" "run"];
      "${mod}+Shift+Q".action = close-window;
      "${mod}+B".action = spawn ["${pkgs.firefox}/bin/firefox" "--name=firefox" "--no-remote" "-P" "default"];
      "${mod}+Shift+B".action = spawn ["${pkgs.firefox}/bin/firefox" "--name=firefox-media" "--no-remote" "-P" "media"];

      # Focus actions
      "${mod}+H".action = focus-column-left;
      "${mod}+J".action = focus-window-down;
      "${mod}+K".action = focus-window-up;
      "${mod}+L".action = focus-column-right;

      # Move windows
      "${mod}+Shift+H".action = move-column-left;
      "${mod}+Shift+J".action = move-window-down;
      "${mod}+Shift+K".action = move-window-up;
      "${mod}+Shift+L".action = move-column-right;

      # Workspaces
      "${mod}+1".action = focus-workspace ws.web;
      "${mod}+2".action = focus-workspace ws.code;
      "${mod}+3".action = focus-workspace ws.notes;
      "${mod}+4".action = focus-workspace ws.chat;
      "${mod}+5".action = focus-workspace ws.media;
      "${mod}+6".action = focus-workspace ws.games;

      "${mod}+Shift+1".action.move-column-to-workspace = [ws.web {focus = false;}];
      "${mod}+Shift+2".action.move-column-to-workspace = [ws.code {focus = false;}];
      "${mod}+Shift+3".action.move-column-to-workspace = [ws.notes {focus = false;}];
      "${mod}+Shift+4".action.move-column-to-workspace = [ws.chat {focus = false;}];
      "${mod}+Shift+5".action.move-column-to-workspace = [ws.media {focus = false;}];
      "${mod}+Shift+6".action.move-column-to-workspace = [ws.games {focus = false;}];

      # Layout actions
      "${mod}+M".action = maximize-column;
      "${mod}+F".action = fullscreen-window;
      "${mod}+V".action = toggle-column-tabbed-display;

      # Resize actions
      "${mod}+Period".action = switch-preset-column-width;
      "${mod}+Comma".action = switch-preset-column-width-back;

      # Floating
      "${mod}+Shift+Space".action = toggle-window-floating;
      "${mod}+Space".action = switch-focus-between-floating-and-tiling;

      # Consume/expel
      "${mod}+I".action = consume-window-into-column;
      "${mod}+O".action = expel-window-from-column;

      # Screenshots
      "${mod}+Shift+S".action.screenshot-window = {};
      "${mod}+Print".action = spawn-sh "${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.wl-clipboard}/bin/wl-copy";

      "${mod}+Tab".action = open-overview;

      # Session
      "${mod}+Control+L".action = spawn ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];
    };

    window-rules = [
      {
        matches = [{app-id = "^firefox$";}];
        open-on-workspace = ws.web;
      }
      {
        matches = [{app-id = "^Alacritty$";}];
        open-on-workspace = ws.code;
      }
      {
        matches = [{app-id = "^obsidian$";}];
        open-on-workspace = ws.notes;
      }
      {
        matches = [{app-id = "^discord$";}];
        open-on-workspace = ws.chat;
      }
      {
        matches = [{app-id = "^teams-for-linux$";}];
        open-on-workspace = ws.chat;
      }
      {
        matches = [{app-id = "^Element$";}];
        open-on-workspace = ws.chat;
      }
      {
        matches = [{app-id = "^spotify$";}];
        open-on-workspace = ws.media;
      }
      {
        matches = [{app-id = "^firefox-media$";}];
        open-on-workspace = ws.media;
      }
      {
        matches = [{app-id = "^steam$";}];
        open-on-workspace = ws.games;
      }
      {
        matches = [{app-id = "steam_app";}];
        open-on-workspace = ws.games;
      }
    ];
  };
}

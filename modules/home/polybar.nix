{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.krath.home.polybar;

  launchPolybar = index: monitor: "MONITOR=${monitor} polybar --reload ${
    if index == 0
    then "primary"
    else "secondary"
  } 2>&1 | ${pkgs.toybox}/bin/tee -a /tmp/polybar-${toString index}.log & disown";
  colors = {
    background = "#282828";
    background-alt = "#3c3836";
    foreground = "#ebdbb2";
    foreground-alt = "#a89984";
    primary = "#fabd2f";
    secondary = "#83a598";
    alert = "#fb4934";
    success = "#b8bb26";
    nix = "#6aaedf";
  };
in {
  options.krath.home.polybar = {
    enable = lib.mkEnableOption "Enable Polybar module";

    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        The monitor ports for connected monitors that should have a polybar.

        The first element of the list uses the primary bar, all the rest use the secondary bar.
      '';
    };

    enableDownload = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable the download module in the right bar.
      '';
    };

    enableUpload = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable the upload module in the right bar.
      '';
    };

    enableBattery = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Enable the battery module in the right bar.
      '';
    };

    fileSystems = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = ''
        The paths to filesystems the filesystem module should monitor in the right bar.
      '';
    };

    thermalZone = lib.mkOption {
      type = lib.types.int;
      description = ''
        The thermal zone used for displaying CPU temperature.

        For more information look up the official Polybar CPU temperature module.
      '';
    };

    thermalType = lib.mkOption {
      type = lib.types.str;
      description = ''
        The thermal type used for displaying CPU temperature.

        For more information look up the official Polybar CPU temperature module.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    services.polybar = let
      download =
        if cfg.enableDownload
        then "network-down"
        else "";
      upload =
        if cfg.enableUpload
        then "network-up"
        else "";
      battery =
        if cfg.enableBattery
        then "battery"
        else "";
    in {
      enable = true;
      package = pkgs.polybar.override {
        i3Support = true;
        alsaSupport = true;
        pulseSupport = true;
      };

      script =
        ''
          # Terminate already running bar instances
          ${pkgs.toybox}/bin/killall -q polybar

          # Wait until the processes have been shut down
          while ${pkgs.toybox}/bin/pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

        ''
        + builtins.concatStringsSep "\n" (lib.imap0 launchPolybar cfg.monitors);

      settings = {
        "bar/primary" = {
          width = "100%";
          height = 28;

          # No rounding of corners
          radius = 0;

          # Tells polybar that the underlying WM is i3 for z-ordering purposes
          wm.restack = "i3";

          background = colors.background;
          foreground = colors.foreground;

          line.size = 3;
          line.color = colors.primary;

          padding.left = 0;
          padding.right = 1;

          # nest, same with others
          module.margin.left = 1;
          module.margin.right = 1;

          # convert to list to see if shit works
          font-0 = "Cascadia Mono NF:size=14;2";
          font-1 = "Cascadia Mono NF:size=16;3";
          font-2 = "Cascadia Mono NF:size=18;3";
          font-3 = "Cascadia Mono NF:size=20;3";

          modules.left = "i3 xwindow";
          modules.center = "date";
          modules.right = "${download} ${upload} filesystem memory cpu temperature pulseaudio tray ${battery}";

          cursor.click = "pointer";
          cursor.scroll = "ns-resize";

          # Tells polybar to respect the MONITOR env var when launching the bar
          monitor = ''''${env:MONITOR:}'';

          monitor-fallback = "";
          monitor-script = false;
          monitor-exact = false;
          enable.ipc = true;
        };

        "bar/secondary" =
          lib.mkIf
          (builtins.length cfg.monitors > 1) {
            "inherit" = "bar/primary";
            modules-right = "${download} ${upload} filesystem memory cpu temperature pulseaudio";
            modules-left = "i3";
          };

        "module/i3" = {
          type = "internal/i3";
          format = "<label-state> <label-mode>";
          index.sort = true;
          wrapping.scroll = false;
          pin.workspaces = true;
          label.mode.padding = 2;
          label.mode.foreground = "#000";
          label.mode.background = colors.primary;

          # Active workspaces
          label-focused = "%index%";
          label.focused.background = colors.background-alt;
          label.focused.underline = colors.primary;
          label.focused.padding = 2;

          # Inactive workspaces
          label-unfocused = "%index%";
          label.unfocused.padding = 2;

          # Active workspace on unfocused monitor
          label-visible = "%index%";
          label.visible.background = colors.background-alt;
          label.visible.underline = colors.background-alt;
          label.visible.padding = 2;

          # Urgent - workspace has something new
          label-urgent = "%index%";
          label.urgent.background = colors.alert;
          label.urgent.padding = 2;
        };

        "module/filesystem" = {
          type = "internal/fs";

          # Update every 25 seconds;
          interval = 25;

          # This is converted to <mount-i> with i being the index in the list
          mount = cfg.fileSystems;

          format-mounted = "<label-mounted>";
          format-mounted-suffix = " 󰋊";
          format-mounted-suffix-foreground = "#616161";
          label-mounted = "%free:4%";

          format-unmounted = "<label-unmounted>";
          label-unmounted = "%mountpoint% not mounted";
          label-unmounted-foreground = colors.foreground-alt;
        };

        "module/memory" = {
          type = "internal/memory";
          interval = 2;
          format-suffix = "%{T4} 󰍛%{T-}";
          format-suffix-foreground = "#4CAF50";
          label = "%percentage_used:3%%";
        };

        "module/cpu" = {
          type = "internal/cpu";
          interval = 2;
          format-suffix = "%{T4} 󰻠%{T-}";
          format-suffix-foreground = colors.primary;
          label = "%percentage:3%%";
        };

        "module/temperature" = {
          type = "internal/temperature";
          interval = 2;
          thermal-zone = cfg.thermalZone;
          zone-type = cfg.thermalType;
          warn-temperature = 80;

          format = "<label> <ramp>";
          format-warn = "<label-warn> <ramp>";

          label = "%temperature-c:4%";
          label-warn = "%temperature-c:4%";
          label-warn-foreground = colors.alert;

          ramp-0 = "󰔏";
          ramp-1 = "󱃂";
          ramp-2 = "󰸁";
          ramp-foreground = "#F44336";
        };

        "module/network-down" = lib.mkIf cfg.enableDownload {
          type = "internal/network";
          interface-type = "wired";
          interval = 2;

          format-connected = "<label-connected>";
          format-connected-suffix = " 󰇚";
          format-connected-suffix-foreground = "#4CAF50";
          label-connected = "%downspeed:10%";

          format-disconnected = "";
        };

        "module/network-up" = lib.mkIf cfg.enableDownload {
          type = "internal/network";
          interface-type = "wired";
          interval = 2;

          format-connected = "<label-connected>";
          format-connected-suffix = " 󰕒";
          format-connected-suffix-foreground = "#2196F3";
          label-connected = "%upspeed:10%";

          format-disconnected = "";
        };

        "module/pulseaudio" = {
          type = "internal/pulseaudio";

          format-volume = "<label-volume> <ramp-volume>";
          label-volume = "%percentage:3%%";
          label-volume-foreground = colors.foreground;

          label-muted = "󰝟 muted";
          label-muted-foreground = colors.foreground-alt;

          ramp-volume-0 = "󰕿";
          ramp-volume-1 = "󰖀";
          ramp-volume-2 = "󰕾";
          ramp-volume-foreground = "#00BCD4";
        };

        "module/date" = {
          type = "internal/date";
          interval = 5;

          date = "%Y-%m-%d";
          date-alt = "%A, %B %d, %Y";

          time = "%H:%M";
          time-alt = "%H:%M:%S";

          format-prefix-foreground = colors.primary;

          label = "%date% %time%";
        };

        "module/tray" = {
          type = "internal/tray";
          tray-size = 20;
          tray-spacing = 8;
          tray-padding = 2;
        };

        "module/battery" = lib.mkIf cfg.enableBattery {
          type = "internal/battery";
          battery = "BAT1";
          adapter = "ACAD";
          poll-interval = 2;

          format-charging = "<label-charging>";
          format-discharging = "<label-discharging>";
          format-full = "<label-full>";

          label-charging = "%percentage%% 󰂄";
          label-discharging = "%percentage%% 󰁾";
          label-full = "100%";
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label = " %class:0:60:...%";
          label-empty = "";
        };
      };
    };
  };
}

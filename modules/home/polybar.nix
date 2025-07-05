{pkgs, ...}: let
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
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };

    script = ''
      # Terminate already running bar instances
      ${pkgs.toybox}/bin/killall -q polybar

      # Wait until the processes have been shut down
      while ${pkgs.toybox}/bin/pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

      # Launch primary monitor with its own log
      MONITOR=DP-4 polybar --reload primary 2>&1 | ${pkgs.toybox}/bin/tee -a /tmp/polybar-primary.log & disown

      # Launch secondary monitor with its own log
      MONITOR=DP-2 polybar --reload secondary 2>&1 | ${pkgs.toybox}/bin/tee -a /tmp/polybar-secondary.log & disown
    '';

    settings = {
      "bar/primary" = {
        width = "98.4%";
        offset.x = "0.8%";
        height = 28;
        offset-y = 10;

        # No rounding of corners
        radius = 0;

        fixed.center = true;

        # Makes floating bars work correctly
        override.redirect = true;

        # Tells polybar that the underlying WM is i3 for z-ordering purposes
        wm.restack = "i3";

        border.size = 1;
        border.color = colors.primary;

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
        font-3 = "Cascadia Mono NF:size=28;7";

        modules.left = "powermenu i3";
        modules.center = "date";
        modules.right = "network-down network-up filesystem memory cpu temperature pulseaudio tray";

        cursor.click = "pointer";
        cursor.scroll = "ns-resize";

        # Tells polybar to respect the MONITOR env var when launching the bar
        monitor = ''''${env:MONITOR:}'';

        monitor-fallback = "";
        monitor-script = false;
        monitor-exact = false;
        enable.ipc = true;
      };

      "bar/secondary" = {
        "inherit" = "bar/primary";
        modules-right = "network-down network-up filesystem memory cpu temperature pulseaudio";
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
        label.visible.underline = colors.primary;
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

        mount-0 = "/";
        mount-1 = "/mnt/external";

        format-mounted = "<label-mounted>";
        format-mounted-suffix = " 󰋊";
        format-mounted-suffix-foreground = colors.primary;
        label-mounted = "%percentage_used:3%%";

        format-unmounted = "<label-unmounted>";
        label-unmounted = "%mountpoint% not mounted";
        label-unmounted-foreground = colors.foreground-alt;
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-suffix = " 󰍛";
        format-suffix-foreground = colors.primary;
        label = "%percentage_used:3%%";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-suffix = " 󰻠";
        format-suffix-foreground = colors.primary;
        label = "%percentage:3%%";
      };

      "module/temperature" = {
        type = "internal/temperature";
        interval = 2;
        thermal-zone = 2;
        zone-type = "x86_pkg_temp";
        warn-temperature = 80;

        format = "<label> <ramp>";
        format-warn = "<label-warn> <ramp>";

        label = "%temperature-c:4%";
        label-warn = "%temperature-c:4%";
        label-warn-foreground = colors.alert;

        ramp-0 = "󰔏";
        ramp-1 = "󱃂";
        ramp-2 = "󰸁";
        ramp-foreground = colors.primary;
      };

      "module/network-down" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 2;

        format-connected = "<label-connected>";
        format-connected-suffix = " 󰇚";
        format-connected-suffix-foreground = colors.primary;
        label-connected = "%downspeed:10%";

        format-disconnected = "";
      };

      "module/network-up" = {
        type = "internal/network";
        interface-type = "wired";
        interval = 2;

        format-connected = "<label-connected>";
        format-connected-suffix = " 󰕒";
        format-connected-suffix-foreground = colors.primary;
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
        ramp-volume-foreground = colors.primary;
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

      "module/powermenu" = {
        type = "custom/menu";

        expand-right = true;
        format-spacing = 1;

        label-open = "%{T4} 󱄅%{T-}";
        label-open-foreground = colors.nix;
        label-close = "%{T3} %{T-}";
        label-separator = "|";
        label-separator-foreground = colors.foreground-alt;

        menu-0-0 = " Lock";
        menu-0-0-exec = "${pkgs.i3lock}/bin/i3lock -c 000000";

        menu-0-1 = "󰒲 Suspend";
        menu-0-1-exec = "${pkgs.systemd}/bin/systemctl suspend";

        menu-0-2 = " Reboot";
        menu-0-2-exec = "${pkgs.systemd}/bin/systemctl reboot";

        menu-0-3 = "⏻ Power off";
        menu-0-3-exec = "${pkgs.systemd}/bin/systemctl poweroff";
      };
    };
  };
}

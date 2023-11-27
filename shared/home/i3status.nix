{ ... }:
{
  programs.i3status = {
    enable = true;
    enableDefault = false;

    general = {
      colors = true;
      color_good = "#bababa";
      color_degraded = "#c7ae46";
      color_bad = "#d17541";
      interval = 5;
    };

    modules = {
      "memory" = {
        enable = true;
        position = 1;
        settings = {
          format = "󰘚 %percentage_used";
        };
      };
      "cpu_usage" = {
        enable = true;
        position = 2;
        settings = {
          format = "  %usage";
          max_threshold = 80;
        };
      };
      "cpu_temperature 0" = {
        enable = true;
        position = 3;
        settings = {
          format = " %degrees °C";
          path = "/sys/devices/platform/coretemp.0/hwmon*/hwmon*/temp1_input";
          max_threshold = 80;
        };
      };
      "load" = {
        enable = true;
        position = 4;
        settings = {
          format = "󰟦  %1min";
          max_threshold = 5;
        };
      };
      # "ethernet _first_" = {
      #   enable = true;
      #   position = 5;
      #   settings = {
      #     format_up = "↑ %speed_up";
      #     format_down = "↓ %speed_down";
      #   };
      # };
      "disk /" = {
        enable = true;
        position = 6;
        settings = {
          format = " %free";
        };
      };
      "volume master" = {
        enable = true;
        position = 7;
        settings = {
          format = "  %volume";
          mixer = "Master";
        };
      };
      "time" = {
        enable = true;
        position = 9;
        settings = {
          format = "󰥔  %Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}

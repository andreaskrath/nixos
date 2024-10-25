{...}: {
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
          format = "RAM %percentage_used";
        };
      };
      "cpu_usage" = {
        enable = true;
        position = 2;
        settings = {
          format = "CPU %usage";
          max_threshold = 80;
        };
      };
      "cpu_temperature 0" = {
        enable = true;
        position = 3;
        settings = {
          format = "TEMP %degrees °C";
          max_threshold = 80;
        };
      };
      "load" = {
        enable = true;
        position = 4;
        settings = {
          format = "LOAD %1min";
          max_threshold = 5;
        };
      };
      "disk /" = {
        enable = true;
        position = 6;
        settings = {
          format = "DISK %free";
        };
      };
      "volume master" = {
        enable = true;
        position = 7;
        settings = {
          format = "VOL %volume";
          mixer = "Master";
        };
      };
      "time" = {
        enable = true;
        position = 9;
        settings = {
          format = "%Y-%m-%d %H:%M:%S";
        };
      };
    };
  };
}

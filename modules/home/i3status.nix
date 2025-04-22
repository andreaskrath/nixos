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
        position = 10;
        settings = {
          format = "RAM %percentage_used";
        };
      };
      "cpu_usage" = {
        enable = true;
        position = 20;
        settings = {
          format = "CPU %usage";
          max_threshold = 80;
        };
      };
      "cpu_temperature 0" = {
        enable = true;
        position = 30;
        settings = {
          format = "TEMP %degrees °C";
          max_threshold = 80;
        };
      };
      "load" = {
        enable = true;
        position = 40;
        settings = {
          format = "LOAD %1min";
          max_threshold = 5;
        };
      };
      "disk /" = {
        enable = true;
        position = 50;
        settings = {
          format = "DISK %free";
        };
      };
      "volume master" = {
        enable = true;
        position = 60;
        settings = {
          format = "VOL %volume";
          mixer = "Master";
        };
      };
      "time" = {
        enable = true;
        position = 70;
        settings = {
          format = "%H:%M:%S %d-%m-%Y";
        };
      };
    };
  };
}

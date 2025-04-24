{...}: {
  programs.i3status.modules = {
    "battery all" = {
      enable = true;
      position = 61;
      settings = {
        format = "%status %percentage %remaining";
        status_chr = "";
        status_bat = "BAT";
        status_full = "BAT";
        low_threshold = 20;
      };
    };
    "cpu_temperature 0" = {
      settings.path = "/sys/devices/virtual/thermal/thermal_zone0/temp";
    };
  };
}

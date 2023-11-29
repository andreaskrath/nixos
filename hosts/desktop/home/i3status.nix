{ ... }:
{
  programs.i3status.modules = {
    "cpu_temperature 0" = {
      settings.path = "/sys/devices/platform/coretemp.0/hwmon*/hwmon*/temp1_input";
    };
  };
}
{ ... }:
{
  services.redshift = {
    enable = true;
    settings.redshift = {
      brightness-day = "1";
      brightness-night = "1";
    };
    temperature = {
      day = 7500;
      night = 7500;
    };
    latitude = "57.0488";
    longitude = "9.9217";
  };
}

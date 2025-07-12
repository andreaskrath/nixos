{homeModules, ...}: {
  imports = [
    ./i3.nix
    ./git.nix
    "${homeModules}/polybar.nix"
  ];

  krath.home = {
    polybar = {
      enable = true;
      enableDownload = true;
      enableUpload = true;

      monitors = ["DP-4" "DP-2"];
      fileSystems = ["/" "/mnt/external"];

      primaryBarWidth = "98.4%";
      xOffset = "0.8%";

      thermalZone = 2;
      thermalType = "x86_pkg_temp";
    };
  };
}

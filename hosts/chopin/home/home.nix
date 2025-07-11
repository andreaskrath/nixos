{
  pkgs,
  homeModules,
  ...
}: {
  imports = [
    ./i3.nix
    ./git.nix
    "${homeModules}/polybar.nix"
  ];

  home.packages = with pkgs; [
    (pkgs.callPackage ./monitor-script.nix {})
    libreoffice
  ];

  krath = {
    polybar = {
      enable = true;
      enableBattery = true;

      monitors = ["eDP"];
      fileSystems = ["/"];

      primaryBarWidth = "97.8%";
      xOffset = "1.1%";

      thermalZone = 0;
      thermalType = "acpitz";
    };
  };
}

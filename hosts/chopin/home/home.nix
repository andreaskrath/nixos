{
  pkgs,
  homeModules,
  ...
}: {
  imports = [
    "${homeModules}/git.nix"
    "${homeModules}/polybar.nix"
    "${homeModules}/i3.nix"
  ];

  home.packages = with pkgs; [
    (pkgs.callPackage ./monitor-script.nix {})
    libreoffice
    azure-cli
  ];

  krath.home = {
    polybar = {
      enable = true;
      enableBattery = true;

      monitors = ["eDP"];
      fileSystems = ["/"];

      thermalZone = 0;
      thermalType = "acpitz";
    };

    i3 = {
      enable = true;
      extraKeybinds = {
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
      };
    };

    git = {
      enable = true;
      allowedSignersKey = "AAAAC3NzaC1lZDI1NTE5AAAAIEmQFlZI9ovaJXVgNv+c3hnLcN8z9ub1pzFSV/4dUeEQ";
    };
  };
}

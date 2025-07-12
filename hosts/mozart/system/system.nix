{modules, ...}: {
  imports = [
    ./games.nix
    ./display.nix
    ./boot.nix
    # ./picom.nix
    ./jellyfin.nix
    "${modules}/stylix.nix"
  ];

  krath.system = {
    stylix = {
      enable = true;
      appFontSize = 10;
      terminalFontSize = 14;
      desktopFontSize = 12;
      popupFontSize = 12;
    };
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };
}

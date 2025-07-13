{modules, ...}: {
  imports = [
    ./games.nix
    ./display.nix
    ./boot.nix
    # ./picom.nix
    "${modules}/stylix.nix"
    "${modules}/jellyfin.nix"
  ];

  krath.system = {
    stylix = {
      enable = true;
      appFontSize = 10;
      terminalFontSize = 14;
      desktopFontSize = 12;
      popupFontSize = 12;
    };

    jellyfin = {
      enable = true;
    };
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };
}

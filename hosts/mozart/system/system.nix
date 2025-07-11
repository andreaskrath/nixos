{modules, ...}: {
  imports = [
    ./games.nix
    ./display.nix
    ./boot.nix
    # ./picom.nix
    ./jellyfin.nix
    "${modules}/stylix.nix"
  ];

  style = {
    enable = true;
    app-fontsize = 10;
    terminal-fontsize = 14;
    desktop-fontsize = 12;
    popup-fontsize = 12;
  };

  services.hardware.openrgb = {
    enable = true;
    motherboard = "intel";
  };
}

{...}: {
  imports = [
    ./games.nix
    ./display.nix
    ./boot.nix
    ./picom.nix
    ../../../modules/system/stylix.nix
  ];

  style = {
    enable = true;
    app-fontsize = 10;
    terminal-fontsize = 14;
    desktop-fontsize = 12;
    popup-fontsize = 12;
  };
}

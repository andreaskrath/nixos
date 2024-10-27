{...}: {
  imports = [
    ./display.nix
    ./boot.nix
    ./network.nix
    ../../../modules/system/stylix.nix
  ];

  style = {
    enable = true;
    app-fontsize = 8;
    terminal-fontsize = 9;
    desktop-fontsize = 10;
    popup-fontsize = 8;
  };
}

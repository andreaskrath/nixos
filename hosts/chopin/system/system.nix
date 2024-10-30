{...}: {
  imports = [
    ./display.nix
    ./boot.nix
    ./network.nix
    ../../../modules/system/stylix.nix
  ];

  style = {
    enable = true;
    app-fontsize = 9;
    terminal-fontsize = 9;
    desktop-fontsize = 10;
    popup-fontsize = 11;
  };
}

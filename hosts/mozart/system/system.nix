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
    fontsize = 14;
  };
}

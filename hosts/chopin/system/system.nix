{...}: {
  imports = [
    ./display.nix
    ./boot.nix
    ./network.nix
    ../../../modules/system/stylix.nix
  ];

  style = {
    enable = true;
    fontsize = 9;
  };
}

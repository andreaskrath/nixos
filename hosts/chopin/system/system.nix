{modules, ...}: {
  imports = [
    ./display.nix
    ./boot.nix
    ./network.nix
    "${modules}/stylix.nix"
  ];

  krath.system = {
    stylix = {
      enable = true;
      appFontSize = 9;
      terminalFontSize = 9;
      desktopFontSize = 10;
      popupFontSize = 11;
    };
  };
}

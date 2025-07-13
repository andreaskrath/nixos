{modules, ...}: {
  imports = [
    ./display.nix
    ./network.nix
    "${modules}/stylix.nix"
    "${modules}/boot.nix"
  ];

  krath.system = {
    boot = {
      enable = true;
      EFIInstallAsRemovable = true;
    };

    stylix = {
      enable = true;
      appFontSize = 9;
      terminalFontSize = 9;
      desktopFontSize = 10;
      popupFontSize = 11;
    };
  };
}

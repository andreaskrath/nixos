{modules, ...}: {
  imports = [
    ./games.nix
    ./display.nix
    # ./picom.nix
    "${modules}/stylix.nix"
    "${modules}/jellyfin.nix"
    "${modules}/boot.nix"
  ];

  krath.system = {
    boot = {
      enable = true;
      canTouchEFIVariables = true;
      kernelModules = ["nvidia"];
      blacklistedKernelModules = ["nouveau"];
    };

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

  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}

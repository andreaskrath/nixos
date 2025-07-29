{
  pkgs,
  config,
  ...
}: {
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = false;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      forceFullCompositionPipeline = true;
    };

    graphics = {
      enable32Bit = true;
    };

    cpu.intel.updateMicrocode = true;
  };
  services.xserver = {
    videoDrivers = ["nvidia"];

    displayManager.setupCommands = ''
      LEFT='DP-2'
      RIGHT='DP-4'
      ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --auto
      ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --auto --left-of $RIGHT
    '';

    screenSection = ''
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
  };
}

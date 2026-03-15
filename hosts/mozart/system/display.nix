{
  config,
  ...
}: {
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
    };

    graphics = {
      enable32Bit = true;
    };

    cpu.intel.updateMicrocode = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  # Required for Wayland on Nvidia
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };
}

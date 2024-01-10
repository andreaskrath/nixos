{ pkgs, config, ... }:
{
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      modesetting.enable = false;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
    };

    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
    
    cpu.intel.updateMicrocode = true;
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];

    displayManager.setupCommands = ''
      LEFT='DP-2'
      RIGHT='DP-4'
      ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --auto
      ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --auto --left-of $RIGHT
    '';

    screenSection = ''
      Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option         "AllowIndirectGLXProtocol" "off"
      Option         "TripleBuffer" "on"
    '';
  };
}

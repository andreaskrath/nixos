{ pkgs, config, ... }:
{
  hardware = {
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
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

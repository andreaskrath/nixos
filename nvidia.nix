{config, ... }:
{
  # Nvidia Configurations
  hardware = {
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };
  services = {
    xserver = {
      enable = true;
      # configures desktop and display managers
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      displayManager.gdm.wayland = false; # disables wayland 
      # configures keymap in X11
      layout = "dk";
      xkbVariant = "";
      # configures gpu drivers
      videoDrivers = [ "nvidia" ];
      # dpi = 96; #fixes screen resolutions
      
      # fix screen tearing - https://nixos.wiki/wiki/Nvidia#Fix_screen_tearing
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
    };
  };
}

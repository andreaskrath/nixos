{ pkgs, config, lib, ... }:
{
  # Nvidia Configurations
  hardware = {
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.production;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };
  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = true;
      windowManager.session = lib.singleton {
        name = "xsession";
        start = pkgs.writeScript "xsession" ''
          #!${pkgs.runtimeShell}
          echo "No windowManager specified, use ~/.XSession"
          exit 1
        '';
      };
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

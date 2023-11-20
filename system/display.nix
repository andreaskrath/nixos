{ pkgs, config, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xrandr
  ];
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
      xautolock.enable = false;
      desktopManager.xterm.enable = false;
      displayManager = {
        lightdm = {
          enable = true;
          greeters.mini = {
            enable = true;
            user = "krath";
            extraConfig = ''
              [greeter]
              show-password-label = true
              password-label-text = Password
              invalid-password-text = Invalid Password
              show-input-cursor = false
              password-alignment = right
              
              [greeter-theme]
              font = Fira Code
              font-weight = bold
              font-style = normal
              font-size = 15
              text-color = "#e0dee3"
              show-image-on-all-monitors = true
              background-image = "${/etc/nixos/home/wallpaper.png}"
              background-color = "#727282"
              window-color = "#37353a"
              bordor-bordor = "#0bb6d9"
              border-width = 1px
              layout-space = 15
              password-color = "#e0dee3"
              password-background-color = "#37353a"
              password-border-width = 0
              password-border-color = "#000000"
            '';
          };
        };
        setupCommands = ''
          LEFT='DP-2'
          RIGHT='DP-4'
          ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --auto
          ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --auto --left-of $RIGHT
        '';
      };
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

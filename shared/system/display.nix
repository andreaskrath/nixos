{
  pkgs,
  lib,
  ...
}: {
  hardware = {
    graphics.enable = true;
    enableRedistributableFirmware = true;
  };
  services.xserver = {
    enable = true;
    xautolock.enable = false;
    desktopManager.xterm.enable = false;
    displayManager.lightdm = {
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
          font = Cascadia Mono
          font-weight = bold
          font-style = normal
          font-size = 15
          text-color = "#e0dee3"
          show-image-on-all-monitors = true
          background-image = "${/etc/nixos/shared/home/wallpaper.png}"
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
    windowManager.session = lib.singleton {
      name = "xsession";
      start = pkgs.writeScript "xsession" ''
        #!${pkgs.runtimeShell}
        echo "No windowManager specified, use ~/.XSession"
        exit 1
      '';
    };
    xkb = {
      variant = "";
      layout = "dk";
    };
  };
}

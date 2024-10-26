{
  pkgs,
  lib,
  ...
}: {
  xsession.windowManager.i3 = {
    config = {
      keybindings = lib.mkAfter {
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
      };
    };
  };
}

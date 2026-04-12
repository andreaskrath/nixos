{pkgs, ...}: let
  xset = pkgs.xset;
in {
  hardware.cpu.amd.updateMicrocode = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services.xserver = {
    videoDrivers = ["amdgpu"];

    displayManager.sessionCommands = ''
      ${xset}/bin/xset s off
      ${xset}/bin/xset -dpms
      ${xset}/bin/xset s noblank
    '';
  };
}

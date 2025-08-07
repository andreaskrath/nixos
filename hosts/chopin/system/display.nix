{pkgs, ...}: {
  hardware.cpu.amd.updateMicrocode = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services.xserver = {
    videoDrivers = ["amdgpu"];

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xset}/bin/xset s off
      ${pkgs.xorg.xset}/bin/xset -dpms
      ${pkgs.xorg.xset}/bin/xset s noblank
    '';
  };
}

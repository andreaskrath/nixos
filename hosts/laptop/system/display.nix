{ ... }:
{
  hardware.cpu.amd.updateMicrocode = true;

  services.xserver = {
    libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
    videoDrivers = [ "amdgpu" ];
  };
}

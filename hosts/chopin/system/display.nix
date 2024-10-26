{...}: {
  hardware.cpu.amd.updateMicrocode = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  services.xserver = {
    videoDrivers = ["amdgpu"];
  };
}

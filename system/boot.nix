{ ... }:
{
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # where to look for boot
    };
  };
}

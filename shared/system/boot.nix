{ ... }:
{
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      efiSupport = true;
      devices = [ "nodev" ];
    };
    efi.efiSysMountPoint = "/boot";
  };
}

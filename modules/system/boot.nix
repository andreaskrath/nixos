{...}: {
  boot.loader = {
    systemd-boot.enable = false;
    grub = {
      enable = true;
      efiSupport = true;
      devices = ["nodev"];

      extraEntries = ''
        menuentry "Shutdown" {
          halt
        }

        menuentry "Reboot" {
          reboot
        }
      '';
    };
    efi.efiSysMountPoint = "/boot";
  };
}

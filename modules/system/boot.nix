{
  config,
  lib,
  ...
}: let
  cfg = config.krath.system.boot;
in {
  options.krath.system.boot = {
    enable = lib.mkEnableOption "Enable boot module.";

    kernelModules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        Kernel modules to add.
      '';
    };

    blacklistedKernelModules = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        Kernel modules to blacklist.
      '';
    };

    canTouchEFIVariables = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether the installation process can touch EFI variables.
      '';
    };

    EFIInstallAsRemovable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether grub should be installed as removable.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      initrd.kernelModules = cfg.kernelModules;
      blacklistedKernelModules = cfg.blacklistedKernelModules;

      loader = {
        systemd-boot.enable = false;

        grub = {
          enable = true;
          efiSupport = true;
          devices = ["nodev"];
          # possibly make an option if mozart complains
          efiInstallAsRemovable = cfg.EFIInstallAsRemovable;

          extraEntries = ''
            menuentry "Shutdown" {
              halt
            }

            menuentry "Reboot" {
              reboot
            }
          '';
        };

        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = cfg.canTouchEFIVariables;
        };
      };
    };
  };
}

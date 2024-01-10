{ ... }:
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "nvidia" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
}

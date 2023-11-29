{ ... }:
{
  imports =
    [
      <home-manager/nixos>
      ./hardware-configuration.nix
      ./system/system.nix
      ../../shared/system/system.nix
      ../../shared/base-config.nix
    ];

  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/60de9566-d001-4586-a3fd-0604a61f428d";
    fsType = "ext4";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.krath = {
      imports = [
        ./home/home.nix
        ../../shared/home/home.nix
      ];
    };
  };
}

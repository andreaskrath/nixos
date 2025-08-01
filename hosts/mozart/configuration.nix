{
  inputs,
  configName,
  homeModules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./system/system.nix
    ../../modules/system/system.nix
    ../../modules/base-config.nix
  ];

  fileSystems."/mnt/external" = {
    device = "/dev/disk/by-uuid/60de9566-d001-4586-a3fd-0604a61f428d";
    fsType = "ext4";
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs configName homeModules;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.krath = {
      imports = [
        ./home.nix
        ../../modules/home/home.nix
      ];
    };
  };
}

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

  home-manager = {
    extraSpecialArgs = {inherit inputs configName homeModules;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users.krath = {
      imports = [
        ./home/home.nix
        ../../modules/home/home.nix
      ];
    };
  };
}

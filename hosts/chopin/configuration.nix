{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ./hardware-configuration.nix
    ./system/system.nix
    ../../modules/system/system.nix
    ../../modules/base-config.nix
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
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

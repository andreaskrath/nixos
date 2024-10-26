{
  pkgs,
  config,
  ...
}: {
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./system/system.nix
    ../../shared/system/system.nix
    ../../shared/base-config.nix
  ];

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

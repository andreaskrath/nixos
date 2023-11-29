{ pkgs, config, ... }:
{
  imports =
    [
      <home-manager/nixos>
      /etc/nixos/hosts/laptop/hardware-configuration.nix
      /etc/nixos/hosts/laptop/system/system.nix
      /etc/nixos/shared/system/system.nix
      /etc/nixos/shared/base-config.nix
    ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.krath = {
      imports = [
        /etc/nixos/hosts/laptop/home/home.nix
        /etc/nixos/shared/home/home.nix
      ];
    };
  };
}

{
  inputs,
  lib,
  ...
}: let
  mkNixOS = {
    hostname,
    system ? "x86_64-linux",
    remote ? false,
  }: let
    hostConfig = ./hosts + "/${hostname}/configuration.nix";
  in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        configName = hostname;
        modules = ./modules/system;
        homeModules = ./modules/home;
        misc = ./misc;
      };
      modules =
        [
          hostConfig
          {
            nixpkgs = {
              system = system;
              config.allowUnfree = true;
            };

            networking.hostName = hostname;

            nix.nixPath = [
              "nixpkgs=${inputs.nixpkgs}"
            ];
          }
        ]
        ++ lib.optionals (!remote) [
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
    };
in {inherit mkNixOS;}

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
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules =
        [
          hostConfig
          {
            nix.nixPath = [
              "nixpkgs=${inputs.nixpkgs}"
            ];
            networking.hostName = hostname;
            nixpkgs.pkgs = pkgs;
          }
        ]
        ++ lib.optionals (!remote) [
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
    };
in {inherit mkNixOS;}

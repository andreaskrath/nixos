{inputs, ...}: let
  mkNixOS = {
    hostname,
    system ? "x86_64-linux",
  }: let
    hostConfig = ./hosts + "/${hostname}/configuration.nix";
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit pkgs inputs;};
      modules = [
        hostConfig
        {
          networking.hostName = hostname;
        }
      ];
    };
in {inherit mkNixOS;}

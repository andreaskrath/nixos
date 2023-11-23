{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    nixosConfigurations = {
      krath = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit system; };
        modules = [
          /etc/nixos/configuration.nix
        ];
      };
    };
  };
}

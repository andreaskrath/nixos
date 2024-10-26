{
  description = "My NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: {
    nixosConfigurations = {
      # desktop
      mozart = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/mozart/configuration.nix
        ];
      };
    };
  };
}

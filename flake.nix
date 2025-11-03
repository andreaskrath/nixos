{
  description = "My NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    with import ./make.nix {
      inherit inputs;
      lib = inputs.nixpkgs.lib;
    }; {
      nixosConfigurations = {
        # desktop
        mozart = mkNixOS {
          hostname = "mozart";
        };

        # laptop
        chopin = mkNixOS {
          hostname = "chopin";
        };

        chiefs = mkNixOS {
          hostname = "chiefs";
          remote = true;
        };
      };
    };
}

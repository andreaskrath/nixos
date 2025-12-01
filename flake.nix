{
  description = "My NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:andreaskrath/zjstatus/fix-lock-file";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
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

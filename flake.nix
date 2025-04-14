{
  description = "My NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:andreaskrath/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # helix-master = {
    #   url = "github:helix-editor/helix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
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

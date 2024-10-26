{inputs, ...}: let
  # might get this working in the future
  # mkHomeManager = {
  #   username,
  #   homeDirectory ? "/home/${username}",
  #   system ? "x86_64-linux",
  # }: let
  #   pkgs = import inputs.nixpkgs {
  #     inherit system;
  #     config.allowUnfree = true;
  #   };
  # in
  #   inputs.home-manager.lib.homeManagerConfiguration {
  #     inherit pkgs inputs;
  #     modules = [
  #       {
  #         home = {
  #           inherit username homeDirectory;
  #           useGlobalPkgs = true;
  #           useUserPackages = true;
  #         };
  #         programs.home-manager.enable = true;
  #       }
  #     ];
  #   };
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

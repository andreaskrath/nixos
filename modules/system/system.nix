{
  pkgs,
  inputs,
  ...
}: let
  agenix = inputs.agenix.packages.${pkgs.system}.default;
in {
  imports = [
    ./audio.nix
    ./display.nix
    ./docker.nix
    ./network.nix
    ./nh.nix
    ./security.nix
    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [
    devenv
    just
    overskride
    agenix

    (callPackage ./scripts/dev.nix {})
    (callPackage ./scripts/flash.nix {})
    (callPackage ./scripts/shows.nix {})
  ];
}

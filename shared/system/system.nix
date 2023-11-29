{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./network.nix
    ./boot.nix
    ./fonts.nix
    ./docker.nix
    ./display.nix
  ];
}

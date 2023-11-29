{ pkgs, ... }:
{
  imports = [
    /etc/nixos/shared/system/audio.nix
    /etc/nixos/shared/system/network.nix
    /etc/nixos/shared/system/boot.nix
    /etc/nixos/shared/system/fonts.nix
    /etc/nixos/shared/system/docker.nix
    /etc/nixos/shared/system/display.nix
  ];
}

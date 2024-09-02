{pkgs, ...}: {
  imports = [
    ./display.nix
    ./boot.nix
    ./network.nix
  ];
}

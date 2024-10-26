{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./network.nix
    ./boot.nix
    ./fonts.nix
    ./docker.nix
    ./display.nix
    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [
    just
    nix-output-monitor
    overskride
  ];
}
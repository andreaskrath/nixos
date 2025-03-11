{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./network.nix
    ./boot.nix
    ./docker.nix
    ./display.nix
    ./settings.nix
  ];

  environment.systemPackages = with pkgs; [
    just
    nix-output-monitor
    overskride

    devenv

    (callPackage ./scripts/flash.nix {})
  ];
}

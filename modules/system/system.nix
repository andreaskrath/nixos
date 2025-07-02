{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./network.nix
    ./boot.nix
    ./docker.nix
    ./display.nix
    ./settings.nix
    ./nh.nix
  ];

  environment.systemPackages = with pkgs; [
    just
    overskride

    devenv

    (callPackage ./scripts/flash.nix {})
    (callPackage ./scripts/shows.nix {})
    (callPackage ./scripts/dev.nix {})
  ];
}

{ pkgs, ... }: {
  imports = [
    ./i3.nix
    ./i3status.nix
    ./alacritty.nix
  ];

  home.packages = [
    (pkgs.callPackage ./monitor-script.nix {})
  ];
}

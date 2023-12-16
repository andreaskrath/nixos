{ pkgs, ... }: {
  imports = [
    ./i3.nix
    ./i3status.nix
    ./alacritty.nix
    ./git.nix
  ];

  home.packages = [
    (pkgs.callPackage ./monitor-script.nix { })
  ];
}

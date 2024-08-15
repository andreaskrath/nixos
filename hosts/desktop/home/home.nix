{pkgs, ...}: {
  imports = [
    ./i3.nix
    ./i3status.nix
    ./alacritty.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    appimage-run
    (pkgs.callPackage ./awakened-poe-trade.nix {})
  ];
}

{pkgs, ...}: {
  imports = [
    ./i3.nix
    ./i3status.nix
    ./alacritty.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    (pkgs.callPackage ./monitor-script.nix {})
    libreoffice
  ];
}

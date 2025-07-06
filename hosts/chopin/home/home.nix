{pkgs, ...}: {
  imports = [
    ./i3.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    (pkgs.callPackage ./monitor-script.nix {})
    libreoffice
  ];
}

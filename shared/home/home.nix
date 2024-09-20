{pkgs, ...}: {
  imports = [
    ./git.nix
    ./i3.nix
    ./i3status.nix
    ./rofi.nix
    ./redshift.nix
    ./alacritty.nix
    ./helix.nix
    ./gtk.nix
    ./direnv.nix
    ./zellij.nix
    ./zsh.nix
  ];

  systemd.user.startServices = true;

  home.username = "krath";
  home.homeDirectory = "/home/krath";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # terminal tools
    tree
    btop
    p7zip
    unzip
    time

    # text editors
    vscode

    # misc
    obsidian
    zotero
    spotify
    bitwarden
    brave
    qbittorrent
    vlc
    element-desktop
    vesktop
    speedcrunch
    thunderbird
  ];

  programs.home-manager.enable = true;
}

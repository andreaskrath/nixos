{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./zsh/zsh.nix
    ./i3.nix
    ./i3status.nix
    ./rofi.nix
    ./redshift.nix
    ./alacritty.nix
    ./helix.nix
    ./gtk.nix
    ./direnv.nix
    # ./neovim/neovim.nix
  ];

  systemd.user.startServices = true;

  home.username = "krath";
  home.homeDirectory = "/home/krath";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # terminal tools
    bat
    tree
    lf
    btop
    p7zip
    unzip

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

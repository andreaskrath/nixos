{pkgs, config, lib, ... }:
let
  oldPkgs = import (pkgs.fetchFromGitHub{
    owner = "nixos";
    repo = "nixpkgs";
		rev = "976fa3369d722e76f37c77493d99829540d43845";
		sha256 = "sha256-zezuNTk1F2Sa3ChTF+wbTn8ujyptQ+E+N6SA2d47zOQ=";
  }) {
    # allows unfree licensed packages from oldPkgs
    config.allowUnfree = true;
  };

  # variable responsible for discord version 0.0.28
  discord_0_0_28 = oldPkgs.discord;
in
{
  imports = [
    ./git.nix
    ./zsh.nix
    ./i3.nix
    ./i3status.nix
    ./rofi.nix
    ./redshift.nix
    ./alacritty.nix
  ];

  home.username = "krath";
  home.homeDirectory = "/home/krath";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # terminal setup
    zsh
    oh-my-zsh

    # terminal tools
    git
    lazygit
    bat
    tree

    # text editors
    vscode

    # misc
    obsidian
    zotero
    spotify
    bitwarden
    brave
    discord_0_0_28
    qbittorrent
  ];

  # Let home-manager install and manage itself
  programs.home-manager.enable = true;

  # directory environment
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.bash.enable = true;

  programs.lazygit = {
    enable = true;
    settings.promptToReturnFromSubprocess = false;
  };
}
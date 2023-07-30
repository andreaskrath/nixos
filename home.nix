{pkgs, config, lib, ... }:
{
  imports = [
    ./git.nix
    ./zsh.nix
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
    discord
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
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
    ./discord/discord.nix
    ./tmux.nix
    ./gtk.nix
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
  ];

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.bash.enable = true;

  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      gui = {
        border = "single";
        mouseEvents = false;
        showBottomLine = false;
        mainPanelSplitMode = "horizontal";
      };
    };
  };

  programs.discord = {
    enable = true;
    wrapDiscord = true;
  };
}

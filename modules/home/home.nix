{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./git.nix
    ./i3.nix
    ./i3status.nix
    ./rofi.nix
    ./redshift.nix
    ./alacritty.nix
    ./direnv.nix
    ./zellij.nix
    ./zsh.nix
    ./zoxide.nix
    ./discord.nix
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
    inputs.nixvim.packages.${pkgs.system}.default
    feh

    # misc
    obsidian
    zotero
    spotify
    bitwarden
    brave
    qbittorrent
    mpv
    element-desktop
    speedcrunch
    thunderbird
    bruno
    beekeeper-studio
  ];
  home.file.".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  programs.home-manager.enable = true;

  programs.discord = {
    enable = true;
    wrapDiscord = true;
  };
}

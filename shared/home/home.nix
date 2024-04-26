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
    ./tmux.nix
    ./gtk.nix
    ./direnv.nix
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
    # vesktop
        (vesktop.overrideAttrs (old: {
      version = "unstable-2024-04-21";

      src = fetchFromGitHub {
        owner = "Vencord";
        repo = "Vesktop";
        rev = "2733727a40a4cf542277dedcf89e87e7740f962d";
        hash = "sha256-EF36HbbhTuAdwBEKqYgBBu7JoP1LJneU78bROHoKqDw=";
      };

      pnpmDeps = old.pnpmDeps.overrideAttrs (_: {
        outputHash = "sha256-6ezEBeYmK5va3gCh00YnJzZ77V/Ql7A3l/+csohkz68=";
      });
    }))
    speedcrunch
    thunderbird
  ];

  programs.home-manager.enable = true;
}

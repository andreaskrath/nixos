{pkgs, ...}: {
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./discord.nix
    ./dunst.nix
    ./neovim.nix
    ./redshift.nix
    ./rofi.nix
    ./zellij.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  systemd.user.startServices = true;

  stylix.enableReleaseChecks = false;

  home.username = "krath";
  home.homeDirectory = "/home/krath";
  home.stateVersion = "23.05";
  home.packages = with pkgs; [
    # terminal tools
    tree
    btop
    p7zip
    zip
    unzip
    unrar
    time
    feh

    # misc
    obsidian
    zotero
    spotify
    bitwarden-desktop
    firefox
    mpv
    element-desktop
    speedcrunch
    thunderbird
    bruno
    jetbrains.datagrip
    teams-for-linux
    pavucontrol
    zathura
    azahar
    melonds
    claude-code
    pokemmo-installer
  ];
  home.file.".config/nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  # Claude Code keybindings
  # Ctrl+E: Open $EDITOR for writing message (save and quit to send)
  home.file.".claude/keybindings.json".text = builtins.toJSON {
    bindings = [
      {
        context = "Chat";
        bindings = {
          "ctrl+g" = null;
          "ctrl+e" = "chat:externalEditor";
        };
      }
    ];
  };

  programs.home-manager.enable = true;

  programs.custom-discord = {
    enable = true;
    wrapDiscord = true;
  };
}

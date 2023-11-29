{ pkgs, ... }:
let
  tmuxinatorBasePath = ".config/tmuxinator";

  nixSessionFileName = "nix";
  nixSessionFilePath = builtins.toJSON {
    name = "nix";
    root = "/etc/nixos";
    attach = false;
    windows = [
      {
        helix = "${pkgs.helix}/bin/hx .";
      }
      {
        git = "${pkgs.lazygit}/bin/lazygit";
      }
      {
        shell = "";
      }
    ];
  };

  kattisSessionFileName = "kattis";
  kattisSessionFilePath = builtins.toJSON {
    name = "kattis";
    root = "Documents/Kattis";
    attach = false;
    windows = [
      {
        helix = "${pkgs.helix}/bin/hx";
      }
      {
        git = "${pkgs.lazygit}/bin/lazygit";
      }
      {
        shell = "";
      }
    ];
  };

  playgroundSessionFileName = "play";
  playgroundSessionFilePath = builtins.toJSON {
    name = "play";
    root = "";
    attach = false;
    windows = [
      {
        helix = "${pkgs.helix}/bin/hx";
      }
      {
        git = "";
      }
      {
        shell = "";
      }
    ];
  };
in
{
  home.file = {
    "${tmuxinatorBasePath}/${nixSessionFileName}".text = "${nixSessionFilePath}";
    "${tmuxinatorBasePath}/${kattisSessionFileName}".text = "${kattisSessionFilePath}";
    "${tmuxinatorBasePath}/${playgroundSessionFileName}".text = "${playgroundSessionFilePath}";
  };

  home.packages = [
    (pkgs.writeShellApplication {
      name = "start-tmux";
      runtimeInputs = with pkgs; [
        findutils
        tmux
        tmuxinator
      ];

      text = ''
        find ${tmuxinatorBasePath} -maxdepth 1 -mindepth 1 -exec tmuxinator start -p {} \;
      '';
    })
  ];

  programs.tmux = {
    tmuxinator.enable = true;
    enable = true;
    package = pkgs.tmux;
    aggressiveResize = false;
    baseIndex = 1;
    clock24 = true;
    customPaneNavigationAndResize = false;
    disableConfirmationPrompt = false;
    escapeTime = 500;
    historyLimit = 2000;
    keyMode = "vi";
    mouse = false;
    newSession = false;
    prefix = "C-Space";
    resizeAmount = 5;
    reverseSplit = false;
    secureSocket = true;
    sensibleOnTop = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";

    extraConfig = ''
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      set -sg escape-time 0
    '';
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_middle_separator " | "

          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules "directory session"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
    ];
  };
}

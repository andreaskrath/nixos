{ pkgs, ... }:
{
  programs.tmux = {
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
    terminal = "screen-256color";

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      set -sg escape-time 0
    '';
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_middle_separator " | "
          
          set -g @catppuccin_window_default_fill "none"
          
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "all"
          
          set -g @catppuccin_status_modules_right "application session user host"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          
          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
        '';
      }
    ];
  };
}

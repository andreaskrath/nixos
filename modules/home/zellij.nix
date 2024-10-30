{inputs, ...}: let
  zjstatus = inputs.zjstatus.packages."x86_64-linux".default;
  colors = {
    red = "#cc241d";
    green = "#98971a";
    yellow = "#d79921";
    blue = "#458588";
    purple = "#b16286";
    aqua = "#689d6a";
    orange = "#d65d0e";
    gray = "#a89984";
  };
in {
  home.file.".config/zellij/layouts/default.kdl".text = ''
    layout {
        default_tab_template {
            children
            pane size=1 borderless=true {
                plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
                    format_left  "{mode}#[fg=#89B4FA,bold] {tabs}"

                    mode_normal        "#[fg=${colors.green}, bold] NORMAL "
                    mode_pane         "#[fg=${colors.yellow}, bold] PANE   "
                    mode_tab          "#[fg=${colors.purple}, bold] TAB    "
                    mode_move           "#[fg=${colors.aqua}, bold] MOVE   "
                    mode_resize         "#[fg=${colors.aqua}, bold] RESIZE "
                    mode_locked          "#[fg=${colors.red}, bold] LOCKED "
                    mode_tmux         "#[fg=${colors.orange}, bold] TMUX   "
                    mode_default_to_mode "tmux"

                    tab_normal               "#[fg=${colors.gray},italic] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                    tab_active               "#[fg=${colors.blue},bold] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                    tab_fullscreen_indicator "□ "
                    tab_sync_indicator       "  "
                    tab_floating_indicator   "󰉈 "
                }
            }
        }
    }
  '';

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      simplified_ui = true;
      pane_frames = false;
      copy_on_select = true;
      plugins = {};
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
    };
  };
}

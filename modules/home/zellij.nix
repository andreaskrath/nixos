{inputs, ...}: let
  zjstatus = inputs.zjstatus.packages."x86_64-linux".default;
in {
  home.file.".config/zellij/layouts/default.kdl".text = ''
    layout {
        default_tab_template {
            children
            pane size=1 borderless=true {
                plugin location="file:${zjstatus}/bin/zjstatus.wasm" {
                    format_left  "{mode}#[fg=#89B4FA,bold] {tabs}"

                    mode_normal          "#[fg=#98971a, bold] NORMAL "
                    mode_tmux            "#[fg=#ffc387, bold] TMUX "
                    mode_default_to_mode "tmux"

                    tab_normal               "#[fg=#6C7086] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
                    tab_active               "#[fg=#9399B2,bold,italic] {index} {name} {fullscreen_indicator}{sync_indicator}{floating_indicator}"
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
      theme = "gruvbox";
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

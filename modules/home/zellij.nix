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
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

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

  home.file.".config/zellij/config.kdl".text = ''
    simplified_ui true
    default_mode "locked"
    mouse_mode true
    pane_frames false
    copy_on_select true
    session_serialization false
    show_startup_tips false

    theme "stylix"
    themes {
        stylix {
            fg 213 196 161
            bg 102 92 84
            red 251 73 52
            green 184 187 38
            yellow 250 189 47
            blue 131 165 152
            magenta 211 134 155
            orange 254 128 25
            cyan 142 192 124
            black 50 48 47
            white 251 241 199
        }
    }

    keybinds clear-defaults=true {
        locked {
            bind "Ctrl g" { SwitchToMode "normal"; }
        }
        pane {
            bind "left" { MoveFocus "left"; }
            bind "down" { MoveFocus "down"; }
            bind "up" { MoveFocus "up"; }
            bind "right" { MoveFocus "right"; }
            bind "c" { SwitchToMode "renamepane"; PaneNameInput 0; }
            bind "d" { NewPane "down"; SwitchToMode "locked"; }
            bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "locked"; }
            bind "f" { ToggleFocusFullscreen; SwitchToMode "locked"; }
            bind "h" { MoveFocus "left"; }
            bind "j" { MoveFocus "down"; }
            bind "k" { MoveFocus "up"; }
            bind "l" { MoveFocus "right"; }
            bind "n" { NewPane; SwitchToMode "locked"; }
            bind "p" { SwitchToMode "normal"; }
            bind "r" { NewPane "right"; SwitchToMode "locked"; }
            bind "w" { ToggleFloatingPanes; SwitchToMode "locked"; }
            bind "x" { CloseFocus; SwitchToMode "locked"; }
            bind "z" { TogglePaneFrames; SwitchToMode "locked"; }
            bind "tab" { SwitchFocus; }
        }
        tab {
            bind "left" { GoToPreviousTab; }
            bind "down" { GoToNextTab; }
            bind "up" { GoToPreviousTab; }
            bind "right" { GoToNextTab; }
            bind "1" { GoToTab 1; SwitchToMode "locked"; }
            bind "2" { GoToTab 2; SwitchToMode "locked"; }
            bind "3" { GoToTab 3; SwitchToMode "locked"; }
            bind "4" { GoToTab 4; SwitchToMode "locked"; }
            bind "5" { GoToTab 5; SwitchToMode "locked"; }
            bind "6" { GoToTab 6; SwitchToMode "locked"; }
            bind "7" { GoToTab 7; SwitchToMode "locked"; }
            bind "8" { GoToTab 8; SwitchToMode "locked"; }
            bind "9" { GoToTab 9; SwitchToMode "locked"; }
            bind "[" { BreakPaneLeft; SwitchToMode "locked"; }
            bind "]" { BreakPaneRight; SwitchToMode "locked"; }
            bind "b" { BreakPane; SwitchToMode "locked"; }
            bind "h" { GoToPreviousTab; }
            bind "j" { GoToNextTab; }
            bind "k" { GoToPreviousTab; }
            bind "l" { GoToNextTab; }
            bind "n" { NewTab; SwitchToMode "locked"; }
            bind "r" { SwitchToMode "renametab"; TabNameInput 0; }
            bind "s" { ToggleActiveSyncTab; SwitchToMode "locked"; }
            bind "t" { SwitchToMode "normal"; }
            bind "x" { CloseTab; SwitchToMode "locked"; }
            bind "tab" { ToggleTab; }
        }
        resize {
            bind "left" { Resize "Increase left"; }
            bind "down" { Resize "Increase down"; }
            bind "up" { Resize "Increase up"; }
            bind "right" { Resize "Increase right"; }
            bind "+" { Resize "Increase"; }
            bind "-" { Resize "Decrease"; }
            bind "=" { Resize "Increase"; }
            bind "H" { Resize "Decrease left"; }
            bind "J" { Resize "Decrease down"; }
            bind "K" { Resize "Decrease up"; }
            bind "L" { Resize "Decrease right"; }
            bind "h" { Resize "Increase left"; }
            bind "j" { Resize "Increase down"; }
            bind "k" { Resize "Increase up"; }
            bind "l" { Resize "Increase right"; }
            bind "r" { SwitchToMode "normal"; }
        }
        move {
            bind "left" { MovePane "left"; }
            bind "down" { MovePane "down"; }
            bind "up" { MovePane "up"; }
            bind "right" { MovePane "right"; }
            bind "h" { MovePane "left"; }
            bind "j" { MovePane "down"; }
            bind "k" { MovePane "up"; }
            bind "l" { MovePane "right"; }
            bind "m" { SwitchToMode "normal"; }
            bind "n" { MovePane; }
            bind "p" { MovePaneBackwards; }
            bind "tab" { MovePane; }
        }
        scroll {
            bind "Alt left" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt down" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt up" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt right" { MoveFocusOrTab "right"; SwitchToMode "locked"; }
            bind "e" { EditScrollback; SwitchToMode "locked"; }
            bind "f" { SwitchToMode "entersearch"; SearchInput 0; }
            bind "Alt h" { MoveFocusOrTab "left"; SwitchToMode "locked"; }
            bind "Alt j" { MoveFocus "down"; SwitchToMode "locked"; }
            bind "Alt k" { MoveFocus "up"; SwitchToMode "locked"; }
            bind "Alt l" { MoveFocusOrTab "right"; SwitchToMode "locked"; }
            bind "s" { SwitchToMode "normal"; }
        }
        search {
            bind "c" { SearchToggleOption "CaseSensitivity"; }
            bind "n" { Search "down"; }
            bind "o" { SearchToggleOption "WholeWord"; }
            bind "p" { Search "up"; }
            bind "w" { SearchToggleOption "Wrap"; }
        }
        session {
            bind "c" {
                LaunchOrFocusPlugin "configuration" {
                    floating true
                    move_to_focused_tab true
                }
                SwitchToMode "locked"
            }
            bind "d" { Detach; }
            bind "o" { SwitchToMode "normal"; }
            bind "p" {
                LaunchOrFocusPlugin "plugin-manager" {
                    floating true
                    move_to_focused_tab true
                }
                SwitchToMode "locked"
            }
            bind "w" {
                LaunchOrFocusPlugin "session-manager" {
                    floating true
                    move_to_focused_tab true
                }
                SwitchToMode "locked"
            }
        }
        shared_among "normal" "locked" {
            bind "Alt left" { MoveFocusOrTab "left"; }
            bind "Alt down" { MoveFocus "down"; }
            bind "Alt up" { MoveFocus "up"; }
            bind "Alt right" { MoveFocusOrTab "right"; }
            bind "Alt +" { Resize "Increase"; }
            bind "Alt -" { Resize "Decrease"; }
            bind "Alt =" { Resize "Increase"; }
            bind "Alt [" { PreviousSwapLayout; }
            bind "Alt ]" { NextSwapLayout; }
            bind "Alt f" { ToggleFloatingPanes; }
            bind "Alt h" { MoveFocusOrTab "left"; }
            bind "Alt i" { MoveTab "left"; }
            bind "Alt j" { MoveFocus "down"; }
            bind "Alt k" { MoveFocus "up"; }
            bind "Alt l" { MoveFocusOrTab "right"; }
            bind "Alt n" { NewPane; }
            bind "Alt o" { MoveTab "right"; }
        }
        shared_except "locked" "renametab" "renamepane" {
            bind "Ctrl g" { SwitchToMode "locked"; }
            bind "Ctrl q" { Quit; }
        }
        shared_except "locked" "entersearch" {
            bind "enter" { SwitchToMode "locked"; }
        }
        shared_except "locked" "entersearch" "renametab" "renamepane" {
            bind "esc" { SwitchToMode "locked"; }
        }
        shared_except "locked" "entersearch" "renametab" "renamepane" "move" {
            bind "m" { SwitchToMode "move"; }
        }
        shared_except "locked" "entersearch" "search" "renametab" "renamepane" "session" {
            bind "o" { SwitchToMode "session"; }
        }
        shared_except "locked" "tab" "entersearch" "renametab" "renamepane" {
            bind "t" { SwitchToMode "tab"; }
        }
        shared_except "locked" "tab" "scroll" "entersearch" "renametab" "renamepane" {
            bind "s" { SwitchToMode "scroll"; }
        }
        shared_among "normal" "resize" "tab" "scroll" "prompt" "tmux" {
            bind "p" { SwitchToMode "pane"; }
        }
        shared_except "locked" "resize" "pane" "tab" "entersearch" "renametab" "renamepane" {
            bind "r" { SwitchToMode "resize"; }
        }
        shared_among "scroll" "search" {
            bind "PageDown" { PageScrollDown; }
            bind "PageUp" { PageScrollUp; }
            bind "left" { PageScrollUp; }
            bind "down" { ScrollDown; }
            bind "up" { ScrollUp; }
            bind "right" { PageScrollDown; }
            bind "Ctrl b" { PageScrollUp; }
            bind "Ctrl c" { ScrollToBottom; SwitchToMode "locked"; }
            bind "d" { HalfPageScrollDown; }
            bind "Ctrl f" { PageScrollDown; }
            bind "h" { PageScrollUp; }
            bind "j" { ScrollDown; }
            bind "k" { ScrollUp; }
            bind "l" { PageScrollDown; }
            bind "u" { HalfPageScrollUp; }
        }
        entersearch {
            bind "Ctrl c" { SwitchToMode "scroll"; }
            bind "esc" { SwitchToMode "scroll"; }
            bind "enter" { SwitchToMode "search"; }
        }
        renametab {
            bind "esc" { UndoRenameTab; SwitchToMode "tab"; }
        }
        shared_among "renametab" "renamepane" {
            bind "Ctrl c" { SwitchToMode "locked"; }
        }
        renamepane {
            bind "esc" { UndoRenamePane; SwitchToMode "pane"; }
        }
    }
  '';
}

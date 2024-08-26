{...}: {
  home.file.".config/zellij/layouts/default.kdl".text = ''
    layout {
      pane
    }
  '';

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      simplified_ui = true;
      pane_frames = false;
      theme = "gruvbox";
      plugins = {};
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
    };
  };
}

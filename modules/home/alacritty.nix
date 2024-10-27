{pkgs, ...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Terminal";
        opacity = 1.0;
        padding = {
          y = 5;
          x = 5;
        };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };
      cursor.style.shape = "Beam";
      shell = {program = "${pkgs.zsh}/bin/zsh";};
    };
  };
}

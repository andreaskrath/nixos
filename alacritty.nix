{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      window = {
        title = "Console";
        opacity = 1.0;
        padding = { y = 5; x= 5; };
        dimensions = {
          lines = 75;
          columns = 100;
        };
      };

      font = {
        normal.family = "Fira Code";
        size = 16.0;
      };

      shell = { program = "${pkgs.zsh}/bin/zsh"; };
    };
  };
}
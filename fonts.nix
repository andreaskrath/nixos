{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      dejavu_fonts
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans " ];
        monospace = [ "Fira Code Nerd Font" ];
      };
    };
  };
}
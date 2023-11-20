{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      fira-code
      fira-code-symbols
      fira-code-nerdfont
      dejavu_fonts
      open-sans
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "Open Sans" ];
        monospace = [ "Fira Code Nerd Font" ];
      };
    };
  };
}

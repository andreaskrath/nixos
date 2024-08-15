{pkgs, ...}: {
  home.packages = [pkgs.dconf];
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 24;
    };
    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    font = {
      package = pkgs.dejavu_fonts;
      name = "Open Sans";
      size = 12;
    };
  };

  home.file.".Xresources".text = ''
    Xcursor.theme: Bibata-Original-Classic
    Xcursor.size: 24
  '';
}

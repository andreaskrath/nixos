{ ... }:
{
  programs.i3status.modules."battery all" = {
    enable = true;
      position = 8;
      settings = {
        format = " %remaining";
    };
  };
}
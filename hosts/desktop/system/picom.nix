{...}: {
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = false;

    settings = {
      mark-wmwin-focus = true;
      mark-ovredir-focused = true;
      use-ewhm-active-win = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      refresh-rate = 0;
      dbe = false;
      paint-on-overlay = true;
      unredir-if-possible = true;
      detect-transient = true;
      detect-client-leader = true;
      invert-color-include = [];
    };
  };
}

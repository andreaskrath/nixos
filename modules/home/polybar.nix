{pkgs, ...}: {
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };

    config = ./polybar-config;
    script = ''
      # Terminate already running bar instances
      ${pkgs.toybox}/bin/killall -q polybar

      # Wait until the processes have been shut down
      while ${pkgs.toybox}/bin/pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

      # Launch primary monitor with its own log
      MONITOR=DP-4 polybar --reload primary 2>&1 | ${pkgs.toybox}/bin/tee -a /tmp/polybar-primary.log & disown

      # Launch secondary monitor with its own log
      MONITOR=DP-2 polybar --reload secondary 2>&1 | ${pkgs.toybox}/bin/tee -a /tmp/polybar-secondary.log & disown
    '';
  };
}

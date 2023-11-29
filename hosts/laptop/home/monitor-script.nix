{ pkgs }:
pkgs.writeShellApplication {
  name = "select-display";
  runtimeInputs = with pkgs; [
    rofi
    xorg.xrandr
    gnugrep
    gawk
    coreutils
    autorandr
  ];

  text = ''
    multimonitor() {
      mirror=$(printf "no\\nyes" | rofi -dmenu -i -p "Mirror displays?")
      [ -z "$mirror" ] && return

      primary=$(echo "$screens" | rofi -dmenu -i -p "Primary display?")
      [ -z "$primary" ] && return

      if [ "$(echo "$screens" | grep -cv "$primary")" -ge "2" ]; then
        secondary=$(echo "$screens" | grep -v "$primary" | rofi -dmenu -i -p "Select secondary display:")
      else 
        secondary=$(echo "$screens" | grep -v "$primary")
      fi
      [ -z "$secondary" ] && return

      if [[ "$mirror" == "yes" ]]; then
        xrandr --output "$primary" --auto \
               --output "$secondary" --auto --scale-from 1920x1080 --same-as "$primary"
      else
        direction=$(printf "left\\nright" | rofi -dmenu -i -p "What side of $primary should $secondary be on?")
        xrandr --output "$primary" --auto \
               --output "$secondary" --auto --scale-from 1920x1080 --"$direction"-of "$primary"
      fi
    }

    singlemonitor() {
      monitor=$1
      [ -z "$monitor" ] && return

      xrandr --output "$monitor" --auto "$(echo "$allscreens" | grep -v "\b$monitor" | awk '{print "--output", $1, "--off"}' | paste -sd ' ' -)"
    }

    runautorandr() {
      profile=$(autorandr --list | rofi -dmenu -i -p "Select autorandr profile:")
      [ -z "$profile" ] && return

      autorandr -f -c "$profile"
    }

    allscreens=$(xrandr -q | grep "connected" | awk '{ print$1 }')
    screens=$(xrandr -q | grep " connected" | awk '{ print$1 }')

    # get user selection
    choice=$(printf "%s\\nmulti-monitor\\nautorandr\\nmanual selection" "$screens" | rofi -dmenu -i -p "Select display arangement:")
    case "$choice" in
      "manual selection") arandr; exit ;;
      "autorandr") runautorandr ;;
      "multi-monitor") multimonitor ;;
      *) singlemonitor "$choice" ;;
    esac
  '';
}

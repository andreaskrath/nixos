{pkgs}:
pkgs.writeShellApplication {
  name = "flash";
  runtimeInputs = with pkgs; [
    inotify-tools
  ];

  text = ''
    set -euo pipefail

    firmware="$1"
    post_cmd="''${2:-}"
    sudo_cmd="''${GLOVE80_FLASH_SUDO_CMD:-sudo}"

    echo "Prompting sudo command"
    $sudo_cmd test 1

    echo "Flashing firmware='$firmware'"

    flash_keybard() {
        keyboard_dev="$1"
        echo "Flashing dev $keyboard_dev"
        if ! [ -e /dev/disk/by-label/"$keyboard_dev" ]; then
            inotifywait -qq -e create -t 60 --include "$keyboard_dev" /dev/disk/by-label
        fi

        $sudo_cmd cp "$firmware" "/dev/disk/by-label/$keyboard_dev"
    }

    flash_keybard "GLV80LHBOOT"
    flash_keybard "GLV80RHBOOT"

    if [ -n "''${post_cmd}" ]; then
        echo "Sleeping 5s before running post command"
        sleep 5
        echo "Running post command"
        bash -c "$post_cmd"
    fi

    echo "Finished!"
  '';
}

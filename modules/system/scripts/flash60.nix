{pkgs}:
pkgs.writeShellApplication {
  name = "flash60";
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

    flash_keyboard() {
        keyboard_dev="$1"
        echo "Waiting for $keyboard_dev..."

        # Wait for the by-label directory to exist (created when first labeled device appears)
        timeout=60
        while ! [ -d /dev/disk/by-label ]; do
            sleep 1
            timeout=$((timeout - 1))
            if [ "$timeout" -le 0 ]; then
                echo "Timed out waiting for /dev/disk/by-label to appear"
                exit 1
            fi
        done

        # Now the directory exists — if the device isn't there yet, watch for it
        if ! [ -e /dev/disk/by-label/"$keyboard_dev" ]; then
            inotifywait -qq -e create -t "$timeout" --include "$keyboard_dev" /dev/disk/by-label
        fi

        if ! [ -e /dev/disk/by-label/"$keyboard_dev" ]; then
            echo "$keyboard_dev did not appear in time"
            exit 1
        fi

        echo "Flashing $keyboard_dev"
        $sudo_cmd cp "$firmware" "/dev/disk/by-label/$keyboard_dev"
    }

    flash_keyboard "GO60RHBOOT"
    flash_keyboard "GO60LHBOOT"

    if [ -n "''${post_cmd}" ]; then
        echo "Sleeping 5s before running post command"
        sleep 5
        echo "Running post command"
        bash -c "$post_cmd"
    fi

    echo "Finished!"
  '';
}

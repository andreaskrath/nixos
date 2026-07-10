{pkgs}:
pkgs.writeShellApplication {
  name = "flash60";
  runtimeInputs = with pkgs; [
    inotify-tools
  ];

  text = ''
    set -euox pipefail

    firmware="$1"

    echo "Prompting sudo command"
    sudo test 1

    echo "Flashing firmware='$firmware'"

    flash_keyboard() {
        keyboard_dev="$1"
        echo "Waiting for $keyboard_dev..."

        # Wait for the by-label directory to exist (created when first labeled device appears)
        timeout=60
        while ! [ -e "/dev/disk/by-label/$keyboard_dev" ]; do
            sleep 1
            timeout=$((timeout - 1))
            if [ "$timeout" -le 0 ]; then
                echo "Timed out waiting for /dev/disk/by-label/$keyboard_dev to appear"
                exit 1
            fi
        done

        echo "Flashing $keyboard_dev"
        sudo cp "$firmware" "/dev/disk/by-label/$keyboard_dev"
    }

    flash_keyboard "GO60RHBOOT"
    flash_keyboard "GO60LHBOOT"

    echo "Finished!"
  '';
}

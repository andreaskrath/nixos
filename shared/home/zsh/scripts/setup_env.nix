{pkgs}: let
  basePath = "/etc/nixos/shells/";
in
  pkgs.writeShellApplication {
    name = "setup_env";
    runtimeInputs = [];
    text = ''
      set +o nounset

      if [ -z "$1" ]; then
        echo "Please specify which nix-shell you wish to utilize. Available options are:"
        for file in ${basePath}*
        do
          [[ ! -e "$file" ]] && break
          stripped_prefix=''${file##${basePath}}
          stripped_suffix=''${stripped_prefix%%.nix}
          echo "$stripped_suffix"
        done
        exit 1
      fi

      if ! [ -f "${basePath}$1.nix" ]; then
        echo "The shell you specified '$1' is not a valid shell file. Available options are:"
        for file in ${basePath}*
        do
          [[ ! -e "$file" ]] && break
          stripped_prefix=''${file##${basePath}}
          stripped_suffix=''${stripped_prefix%%.nix}
          echo "$stripped_suffix"
        done
        exit 1
      fi

      echo "use nix" > .envrc
      cat ${basePath}"$1".nix > shell.nix
      direnv allow

      echo "Nix shell setup is complete."
    '';
  }

{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
    bat
    yazi
    i3lock
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      xo = "xdg-open";
      l = "${pkgs.eza}/bin/eza --icons --group-directories-first --group --long --all";
      ll = "${pkgs.eza}/bin/eza --icons --group-directories-first --group --long";
      la = "${pkgs.eza}/bin/eza --icons --group-directories-first --group --long --all -all";
      cat = "${pkgs.bat}/bin/bat";
      ".." = "cd ../";
      "...." = "cd ../../";
      "......" = "cd ../../../";
      ld = "${pkgs.lazydocker}/bin/lazydocker";
      c = "clear";
      f = "${pkgs.yazi}/bin/yazi";
      ports = "${pkgs.unixtools.netstat}/bin/netstat -tulpn";
      lock = "${pkgs.i3lock}/bin/i3lock -n -c 000000";
      gg = ''vi --cmd "lua vim.g.disable_telescope_startup = true" -c "Neogit"'';
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "ssh"
      ];
      theme = "kafeitu";
    };

    initContent = ''
      function current_dir() {
          local current_dir=$PWD
          if [[ $current_dir == $HOME ]]; then
              current_dir="~"
          else
              current_dir=''${current_dir##*/}
          fi

          echo $current_dir
      }

      function change_tab_title() {
          local title=$1
          command nohup zellij action rename-tab $title >/dev/null 2>&1
      }

      function set_tab_to_working_dir() {
          local result=$?
          local title=$(current_dir)
          # uncomment the following to show the exit code after a failed command
          # if [[ $result -gt 0 ]]; then
          #     title="$title [$result]"
          # fi

          change_tab_title $title
      }

      function set_tab_to_command_line() {
          local cmdline=$1
          change_tab_title $cmdline
      }

      if [[ -n $ZELLIJ ]]; then
          add-zsh-hook precmd set_tab_to_working_dir
          add-zsh-hook preexec set_tab_to_command_line
      fi
    '';
  };
}

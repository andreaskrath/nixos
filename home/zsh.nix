{pkgs,...}: 
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      xo = "xdg-open";
      ll = "ls -l";
      la = "ls -A";
      cat = "bat";
      ".." = "cd ../";
      "...." = "cd ../../";
      "......" = "cd ../../../";
      update = "sudo nixos-rebuild switch";
      lg = "lazygit";
    };

    initExtra = ''
      eval "$(direnv hook zsh)"
      # a function to setup direnv based on predefined shells in /etc/nix/shells
      setup_env() {
        if [ -z "$1" ]; then
          echo "Please specify which shell you wish to utilize. Available options are:"
          ls /etc/nixos/shells
          return 1
        fi

        echo "use nix" > .envrc
        echo "(import /etc/nixos/shells/$1.nix)" > shell.nix
        direnv allow

        echo "Nix environment setup is complete."
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
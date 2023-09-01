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
      setup_env = "touch .envrc && touch shell.nix && echo 'use nix' >> .envrc && echo '(import /etc/nixos/shells/PLACEHOLDER.nix)' >> shell.nix && echo 'replace PLACEHOLDER in shell.nix and type: direnv allow'";
      lg = "lazygit";
    };

    initExtra = ''
      export VISUAL="code -nw" # allows for the "sudo -e" command to open in vscode
      eval "$(direnv hook zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
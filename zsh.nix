{pkgs,...}: 
{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    shellAliases = {
      xo = "xdg-open";
      ll = "ls -l";
      la = "ls -A";
      cat = "bat";
      ".." = "cd ../";
      "...." = "cd ../../";
      "......" = "cd ../../../";
      update = "sudo nixos-rebuild switch";
      setup_rust_env = "touch .envrc && touch shell.nix && echo 'use nix' >> .envrc && echo '(import /etc/nixos/shells/rust.nix)' >> shell.nix && direnv allow";
      setup_go_env = "touch .envrc && touch shell.nix && echo 'use nix' >> .envrc && echo '(import /etc/nixos/shells/go.nix)' >> shell.nix && direnv allow";
      setup_gorust_env = "touch .envrc && touch shell.nix && echo 'use nix' >> .envrc && echo '(import /etc/nixos/shells/gorust.nix)' >> shell.nix && direnv allow";
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
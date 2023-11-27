{ pkgs, ... }:
{
  home.packages = [
    (import /etc/nixos/shared/home/zsh/scripts/setup_env.nix { inherit pkgs; })
    (import /etc/nixos/shared/home/zsh/scripts/justfiles.nix { inherit pkgs; })
  ];
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      xo = "xdg-open";
      ll = "ls -l";
      la = "ls -A";
      cat = "${pkgs.bat}/bin/bat";
      ".." = "cd ../";
      "...." = "cd ../../";
      "......" = "cd ../../../";
      switch = "sudo nixos-rebuild switch";
      boot = "sudo nixos-rebuild boot";
      lg = "${pkgs.lazygit}/bin/lazygit";
    };

    initExtra = ''
      eval "$(direnv hook zsh)"
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}

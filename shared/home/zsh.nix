{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
    bat
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
      lg = "${pkgs.lazygit}/bin/lazygit";
      ld = "${pkgs.lazydocker}/bin/lazydocker";
      config = "/etc/nixos";
      c = "clear";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "ssh"
      ];
      theme = "kafeitu";
    };
  };
}

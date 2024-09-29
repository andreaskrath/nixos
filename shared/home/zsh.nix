{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
    bat
    yazi
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
      c = "clear";
      f = "${pkgs.yazi}/bin/yazi";
      ports = "${pkgs.unixtools.netstat}/bin/netstat -tulpn";
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

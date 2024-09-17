{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    eza
    bat
  ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
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
      lg = "${pkgs.lazygit}/bin/lazygit";
      ld = "${pkgs.lazydocker}/bin/lazydocker";
      config = "/etc/nixos";
    };

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "ssh"
      ];
      theme = "kafeitu";
    };
  };
}

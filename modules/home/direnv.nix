{...}: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}

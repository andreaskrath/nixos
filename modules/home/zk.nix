{...}: {
  programs.zsh.envExtra = ''
    export ZK_NOTEBOOK_DIR="$HOME/vault"
  '';

  programs.zk = {
    enable = true;
  };
}

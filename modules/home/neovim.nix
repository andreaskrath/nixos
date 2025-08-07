{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      ripgrep
      xclip
      lua-language-server
      taplo
      nil
      alejandra
      clang # For treesitter grammars
    ];
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/nvim;
}


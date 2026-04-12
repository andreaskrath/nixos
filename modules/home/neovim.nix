{
  config,
  inputs,
  pkgs,
  ...
}: {
  stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;
    package = inputs.neovim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.neovim-unwrapped;
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

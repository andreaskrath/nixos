{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = builtins.readFile ./options.lua;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }
      
      {
        plugin = comment-nvim;
        config = builtins.readFile ./plugin/comment.lua;
        type = "lua";
      }
    ];
  };
}

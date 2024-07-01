{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = builtins.readFile ./options.lua;

    extraPackages = with pkgs; [
      rust-analyzer # rust lsp
    ];

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

      {
        plugin = nvim-tree-lua;
        config = builtins.readFile ./plugin/nvim-tree.lua;
        type = "lua";
      }

  	  {
  	  	plugin = rustaceanvim;
    		config = builtins.readFile ./plugin/rustaceanvim.lua;
  	  	type = "lua";
  	  }
      }
    ];
  };
}

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

      {
        plugin = nvim-cmp;
        config = builtins.readFile ./plugin/cmp.lua;
        type = "lua";
      }
      cmp-nvim-lsp
      cmp-cmdline

      {
        plugin = lsp_lines-nvim;
        config = builtins.readFile ./plugin/lsp_lines.lua;
        type = "lua";
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-json
          p.tree-sitter-rust
          p.tree-sitter-go
          p.tree-sitter-svelte
        ]));
        config = builtins.readFile ./plugin/treesitter.lua;
        type = "lua";
      }

	  {
		plugin = gitsigns-nvim;
		config = builtins.readFile ./plugin/gitsigns.lua;
		type = "lua";
	  }

	  {
		plugin = lualine-nvim;
		config = builtins.readFile ./plugin/lualine.lua;
		type = "lua";
	  }
    ];
  };
}

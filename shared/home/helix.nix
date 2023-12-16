{ pkgs, ... }:
{
  home.packages = [
    pkgs.nixpkgs-fmt
  ];
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      marksman # markdown lsp
      nil # nix lsp
      rust-analyzer # rust lsp
      taplo # toml toolkit
      gopls # go lsp
      lldb # debugger 
    ];

    settings = {
      theme = "onedark";
      editor = {
        mouse = false;
        middle-click-paste = false;
        shell = [ "${pkgs.zsh}/bin/zsh" "-c" ];
        line-number = "relative";
        color-modes = true;
        auto-completion = true;
        auto-format = true;
        idle-timeout = 200;
        bufferline = "always";
        gutters = [ "diagnostics" "line-numbers" "spacer" "diff" ];
        preview-completion-insert = false;
        
        lsp = {
          display-messages = true;
          auto-signature-help = false;
        };
        
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        indent-guides = {
          render = true;
        };

        statusline = {
          separator = "|";
          left = [ "mode" "spinner" "version-control" "file-modification-indicator" ];
          center = [ "read-only-indicator" ];
          right = [ "diagnostics" "file-type" "total-line-numbers" "position" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
      };

      keys.normal = {
        space = {
          w = ":w";
          W = ":w!";
          q = ":q";
          Q = ":q!";
          c = ":buffer-close";
          C = ":buffer-close!";
        };
        "C-j" = [ "delete_selection" "paste_after" ];
        "C-k" = [ "delete_selection" "move_line_up" "paste_before" ];
      };
    };

    languages = {
      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
      };

      language-server.rust-analyzer = {
        config = {
          procMacro.enable = true;

          cargo = {
            autoreload = true;
            buildScripts.enable = true;
            features = "all";
          };

          completion = {
            autoimport.enable = true;
            autoself.enable = true;
          };

          check = {
            command = "clippy";
            extraArgs = [ "--tests" "--" "-W" "clippy::all" ];
          };

          lens = {
            enable = true;
            debug.enable = true;
            implementations.enable = true;
            references = {
              adt.enable = true;
              enumVariant.enable = true;
              method.enable = true;
              trait.enable = true;
            };
          };
        };
      };

      language-server.gopls = {
        command = "${pkgs.gopls}/bin/gopls";
      };

      language-server.taplo = {
        command = "${pkgs.taplo}/bin/taplo";
      };
    };
  };
}

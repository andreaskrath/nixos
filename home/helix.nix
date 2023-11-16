{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      marksman # markdown lsp
      nil # nix lsp
      nixpkgs-fmt # nix formatter
      rust-analyzer # rust lsp
    ];
    
    settings = {
      theme = "autumn";
      editor = {
        mouse = false;
        middle-click-paste = false;
        shell = [ "${pkgs.zsh}/bin/zsh" "-c" ];
        line-number = "relative";
        auto-completion = true;
        auto-format = true;
        idle-timeout = 200;
        bufferline = "always";
        gutters = [ "diagnostics" "line-numbers" "spacer" "diff" ];
        lsp.display-messages = true;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
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
    };

    languages = {
      nil = {
        command = "${pkgs.nil}/bin/nil";
        config.nil = {
          formatting.command = [ "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt" ];
        };
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
    };
  };
}

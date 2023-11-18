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
      keys.normal = {
        space.w = ":w";
        space.q = ":q";
      };
      keys.normal."+" = {
        t = ":run-shell-command just test";
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
    };
  };
}

{pkgs, ...}: let
  helixSrc = pkgs.fetchFromGitHub {
    owner = "helix-editor";
    repo = "helix";
    rev = "38e6fcd5c51478635ffa405815c7b9bbeadc35a9";
    hash = "sha256-+nUWRR6mV+EV6pG51tgTG7CckGrHcp3Fq6zz0OzcA9w=";
  };

  helixPkg = import helixSrc;
in {
  programs.helix = {
    enable = true;
    package = helixPkg.default;
    defaultEditor = true;

    extraPackages = with pkgs; [
      marksman # markdown lsp
      nil # nix lsp
      alejandra # nix formatter
      rust-analyzer # rust lsp
      taplo # toml toolkit
      gopls # go lsp
      golangci-lint-langserver # go linting lsp
      svelte-language-server #svelte lsp
      python312Packages.python-lsp-server # python3 lsp
      haskell-language-server # haskell lsp
    ];

    settings = {
      theme = "gruvbox_dark_soft";
      editor = {
        mouse = false;
        middle-click-paste = false;
        shell = ["${pkgs.zsh}/bin/zsh" "-c"];
        line-number = "relative";
        color-modes = true;
        auto-completion = true;
        auto-format = true;
        idle-timeout = 0;
        bufferline = "always";
        gutters = ["diagnostics" "line-numbers" "spacer" "diff"];
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

        statusline = {
          separator = "|";
          left = ["mode" "spinner" "version-control" "file-modification-indicator"];
          center = ["read-only-indicator"];
          right = ["diagnostics" "file-type" "total-line-numbers" "position"];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
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
          t = ":run-shell-command ${pkgs.zellij}/bin/zellij run -f -- ${pkgs.direnv}/bin/direnv exec . just test";
        };
        "C-j" = ["delete_selection" "paste_after"];
        "C-k" = ["delete_selection" "move_line_up" "paste_before"];
        X = ["extend_line_up" "extend_to_line_bounds"];
      };
    };

    languages = {
      language-server.nil = {
        command = "${pkgs.nil}/bin/nil";
        config = {
          nil = {
            nix = {
              binary = "/run/current-system/sw/bin/nix";
            };
            formatting = {
              command = ["${pkgs.alejandra}/bin/alejandra" "--"];
            };
          };
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
        }
      ];

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
            extraArgs = ["--tests" "--" "-W" "clippy::all"];
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

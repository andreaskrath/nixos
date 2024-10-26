{
  pkgs,
  inputs,
  ...
}: {
  programs.helix = {
    enable = true;
    package = inputs.helix-master.packages."x86_64-linux".default;
    defaultEditor = true;

    extraPackages = with pkgs; [
      xclip # clipboard utility

      marksman # markdown lsp
      nixd # nix lsp
      alejandra # nix formatter
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
        end-of-line-diagnostics = "hint";

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
          other-lines = "disable";
        };
      };

      keys = {
        normal = {
          space = {
            w = ":w";
            W = ":w!";
            q = ":q";
            Q = ":q!";
            c = ":buffer-close";
            C = ":buffer-close!";
          };
          "C-j" = ["delete_selection" "paste_after"];
          "C-k" = ["delete_selection" "move_line_up" "paste_before"];
          X = ["extend_line_up" "extend_to_line_bounds"];
          n = {
            d = ["goto_next_diag" "align_view_center"];
            D = ["goto_last_diag" "align_view_center"];
            f = ["goto_next_function" "align_view_center"];
            t = ["goto_next_test" "align_view_center"];
          };
          N = {
            d = ["goto_prev_diag" "align_view_center"];
            D = ["goto_first_diag" "align_view_center"];
            f = ["goto_prev_function" "align_view_center"];
            t = ["goto_prev_test" "align_view_center"];
          };
          "*" = ["move_prev_word_start" "move_next_word_end" "search_selection" "global_search"];
        };
      };
    };

    languages = {
      language-server.nixd = {
        command = "${pkgs.nixd}/bin/nixd";
        config = {
          nixd = {
            formatting.command = ["${pkgs.alejandra}/bin/alejandra" "--"];
            nixpkgs.expr = ''import (builtins.getFlake "/etc/nixos").inputs.nixpkgs {}'';
          };
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = ["nixd"];
        }

        {
          name = "haskell";
          auto-format = true;
        }
      ];

      language-server.rust-analyzer = {
        config = {
          procMacro.enable = true;

          cargo = {
            autoreload = true;
            buildScripts.enable = true;
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
        command = "gopls";
      };

      language-server.taplo = {
        command = "taplo";
      };

      language-server.haskell-language-server = {
        config.haskell.formattingProvider = "ormolu";
      };
    };
  };
}

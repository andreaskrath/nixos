{pkgs, ...}: let
  # pin for now due to termial cursor bug https://github.com/helix-editor/helix/issues/10089
  pin =
    import
    (pkgs.fetchFromGitHub {
      owner = "nixos";
      repo = "nixpkgs";
      rev = "a3ed7406349a9335cb4c2a71369b697cecd9d351";
      sha256 = "sha256-PDwAcHahc6hEimyrgGmFdft75gmLrJOZ0txX7lFqq+I=";
    })
    {};
in {
  programs.helix = {
    enable = true;
    package = pin.helix;
    defaultEditor = true;

    extraPackages = with pkgs; [
      marksman # markdown lsp
      nil # nix lsp
      alejandra # nix formatter
      rust-analyzer # rust lsp
      taplo # toml toolkit
      gopls # go lsp
      lldb # debugger
      svelte-language-server #svelte lsp
      python3
    ];

    settings = {
      theme = "onedark";
      editor = {
        mouse = false;
        middle-click-paste = false;
        shell = ["${pkgs.zsh}/bin/zsh" "-c"];
        line-number = "relative";
        color-modes = true;
        auto-completion = true;
        auto-format = true;
        idle-timeout = 200;
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
          name = "rust";
          debugger = {
            name = "lldb-vscode";
            transport = "stdio";
            command = "${pkgs.lldb}/bin/lldb-vscode";
            templates = [
              {
                name = "binary";
                request = "launch";
                completion = [
                  {
                    name = "binary";
                    completion = "filename";
                  }
                ];
                args = {
                  program = "{0}";
                  initCommands = [
                    "command script import /etc/nixos/shared/home/rustc_lldb.py"
                  ];
                };
              }
            ];
          };
        }

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

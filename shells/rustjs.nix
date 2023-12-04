{ pkgs ? import <nixpkgs> { overlays = [ (import <rust-overlay>) ]; } }:
let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    rust
    vscode-extensions.rust-lang.rust-analyzer

    # required for things like tokio
    pkg-config
    openssl

    # basic js
    nodejs
    yarn
    nodePackages.npm
    nodePackages.prettier # formatter
    nodePackages.eslint # linter

    # svelte
    nodePackages.svelte-check
    nodePackages.svelte-language-server
    vscode-extensions.svelte.svelte-vscode

    # typescript
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  # environment variables
  # RUST_BACKTRACE = "full";
}

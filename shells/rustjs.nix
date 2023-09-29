{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    gcc
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
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

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  RUST_BACKTRACE = "1";
}
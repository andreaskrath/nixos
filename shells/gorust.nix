{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # both
    gcc

    # golang
    go
    gopls
    vscode-extensions.golang.go

    # rust
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    vscode-extensions.rust-lang.rust-analyzer
  ];

  # rust env
  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  RUST_BACKTRACE = "1";
}
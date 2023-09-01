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
  ];

  RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  RUST_BACKTRACE = "1";
}
{ pkgs ? import <nixpkgs> { overlays = [ (import <rust-overlay>) ];} }:
let
  rust = pkgs.rust-bin.selectLatestNightlyWith(toolchain: toolchain.default.override {
    extensions = [ "rust-src" ];
    targets = [ "wasm32-unknown-unknown" ];
    });
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    rust
    vscode-extensions.rust-lang.rust-analyzer
    cargo-leptos

    # required for things like tokio
    pkg-config
    openssl
  ];

  RUST_BACKTRACE = "full";
}
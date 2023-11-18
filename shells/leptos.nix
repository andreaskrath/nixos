{ pkgs ? import <nixpkgs> { overlays = [ (import <rust-overlay>) ]; } }:
let
  rust = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
    extensions = [ "rust-src" ];
    targets = [ "wasm32-unknown-unknown" ];
  });
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    rust
    cargo-leptos
    cargo-generate
    trunk
    tailwindcss

    # required for things like tokio
    pkg-config
    openssl

    # basic js
    nodejs
    nodePackages.npm
    nodePackages.prettier # formatter
    nodePackages.eslint # linter

    # typescript
    nodePackages.typescript
    nodePackages.typescript-language-server
  ];

  RUST_BACKTRACE = "1";
}

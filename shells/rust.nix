{ pkgs ? import <nixpkgs> { overlays = [ (import <rust-overlay>) ]; } }:
let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    rust

    # tokio
    pkg-config
    openssl

    # command runner
    just

    # watch cargo commands
    cargo-watch
  ];
  # environment variables
  # RUST_BACKTRACE = "1";
}

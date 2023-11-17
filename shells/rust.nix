{ pkgs ? import <nixpkgs> { overlays = [ (import <rust-overlay>) ];} }:
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

    # command runner
    just

    # watch cargo commands
    cargo-watch
    ];

  RUST_BACKTRACE = "full";
}

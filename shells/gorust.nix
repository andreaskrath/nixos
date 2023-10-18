{ pkgs ? import <nixpkgs> { overlays = [ (import <rust-overlay>) ];} }:
let
  rust = pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  };
in
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    # both
    gcc

    # golang
    go
    gopls
    vscode-extensions.golang.go

    # rust
    rust
    vscode-extensions.rust-lang.rust-analyzer
  ];

  RUST_BACKTRACE = "1";
}
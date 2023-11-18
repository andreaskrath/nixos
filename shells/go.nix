{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    gcc
    go
    gopls # language server
    vscode-extensions.golang.go
  ];
}

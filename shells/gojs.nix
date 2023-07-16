{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    gcc
    go
    gopls # language server
    vscode-extensions.golang.go
    
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
}
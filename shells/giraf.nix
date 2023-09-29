{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    jetbrains.rider
    dotnet-sdk_8
    docker
    docker-client
    lazydocker
  ];

  DOTNET_ROOT="${pkgs.dotnet-sdk_8}";
}

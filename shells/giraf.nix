{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    jetbrains.rider
    dotnet-sdk_8
  ];

  shellHook =
  ''
    export PATH="$PATH:/home/krath/.dotnet/tools"
  '';

  DOTNET_ROOT="${pkgs.dotnet-sdk_8}";
}

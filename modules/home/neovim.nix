{
  config,
  inputs,
  pkgs,
  lib,
  ...
}: let
  packages = with pkgs; [
    ripgrep
    xclip
    lua-language-server
    taplo
    nil
    alejandra
    clang
  ];

  # Stopped using home manager neovim package because it often changes internals that
  # generated more random files causing weird interactions in my config.
  neovim =
    pkgs.wrapNeovim
    inputs.neovim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.neovim-unwrapped
    {
      viAlias = true;
      vimAlias = true;
      extraMakeWrapperArgs = "--prefix PATH : ${lib.makeBinPath packages}";
    };
in {
  home.packages = [neovim];

  # Whenever an error is `Error installing file '<file-path>' outside $HOME`,
  # it is incredibly likely the underlying issue is because something else is
  # trying to place a file at the same file path, this could be home manager, stylix or whatever.
  #
  # The error message itself is just horrendous.
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/nvim;
}

{ pkgs, ... }: {
  imports = [
    /etc/nixos/hosts/laptop/home/i3.nix
    /etc/nixos/hosts/laptop/home/i3status.nix
    /etc/nixos/hosts/laptop/home/alacritty.nix
  ];

  home.packages = [
    (pkgs.callPackage ./monitor-script.nix {})
  ];
}

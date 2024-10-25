default:
    just --list

switch:
    @git add .
    sudo nixos-rebuild switch --flake . |& nom

boot:
    @git add .
    sudo nixos-rebuild boot --flake . |& nom

deploy ACTION:
    nixos-rebuild -I nixos-config=./hosts/chiefs/configuration.nix --target-host root@datamagikeren.dk {{ACTION}} |& nom


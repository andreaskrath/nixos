default:
    just --list

switch:
    sudo nixos-rebuild switch |& nom

boot:
    sudo nixos-rebuild boot |& nom

deploy ACTION:
    nixos-rebuild -I nixos-config=./hosts/chiefs/configuration.nix --target-host root@datamagikeren.dk {{ACTION}} |& nom


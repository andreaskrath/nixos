default:
    just --list

switch:
    sudo nixos-rebuild switch

boot:
    sudo nixos-rebuild boot

deploy ACTION:
    nixos-rebuild -I nixos-config=./hosts/chiefs/configuration.nix --target-host root@datamagikeren.dk {{ACTION}}


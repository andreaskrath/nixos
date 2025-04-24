default:
    just --list

switch:
    @git add .
    @sudo true
    sudo nixos-rebuild switch --flake . |& nom

boot:
    @git add .
    @sudo true
    sudo nixos-rebuild boot --flake . |& nom

deploy ACTION:
    nixos-rebuild --flake .#chiefs --target-host root@datamagikeren.dk {{ACTION}} |& nom


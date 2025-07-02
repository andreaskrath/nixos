default:
    @just --list

switch:
    @git add .
    @nh os switch .

boot:
    @git add .
    @nh os boot .

deploy ACTION:
    nixos-rebuild --flake .#chiefs --target-host root@datamagikeren.dk {{ACTION}} |& nom


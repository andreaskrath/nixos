default:
    just --list

switch:
    @git add .
    @sudo true
    nh os switch .

boot:
    @git add .
    @sudo true
    nh os boot .

deploy ACTION:
    nixos-rebuild --flake .#chiefs --target-host root@datamagikeren.dk {{ACTION}} |& nom


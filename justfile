default:
    @just --list

switch:
    @git add .
    @nh os switch .

boot:
    @git add .
    @nh os boot .

deploy ACTION:
    @git add .
    @nh os {{ACTION}} .#nixosConfigurations.chiefs --target-host root@datamagikeren.dk


default:
    @just --list

switch:
    @git add .
    @nh os switch .

boot:
    @git add .
    @nh os boot .

deploy HOST ACTION:
    #!/usr/bin/env bash
    git add .
    case {{HOST}} in
        chiefs) target="datamagikeren.dk" ;;
        arsenal) target="192.168.0.158" ;;
        *) echo "Unknown host: {{HOST}}"; exit 1 ;;
    esac
    nh os {{ACTION}} .#nixosConfigurations.{{HOST}} --target-host root@$target

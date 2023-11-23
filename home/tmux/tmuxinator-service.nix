{ pkgs, ... }:
let
  tmuxinatorBasePath = "$HOME/.config/tmuxinator";

  nixSessionFileName = "nix";
  nixSessionFilePath = builtins.toJSON {
    name = "nix";
    root = "/etc/nixos";
    attach = false;
    windows = [
      {
        helix = "${pkgs.helix}/bin/hx .";
      }
      {
        git = "${pkgs.lazygit}/bin/lazygit";
      }
      {
        shell = "";
      }
    ];
  };

  kattisSessionFileName = "kattis";
  kattisSessionFilePath = builtins.toJSON {
    name = "kattis";
    root = "$HOME/Documents/Kattis";
    attach = false;
    windows = [
      {
        helix = "${pkgs.helix}/bin/hx";
      }
      {
        git = "${pkgs.lazygit}/bin/lazygit";
      }
      {
        shell = "";
      }
    ];
  };

  playgroundSessionFileName = "play";
  playgroundSessionFilePath = builtins.toJSON {
    name = "play";
    root = "$HOME";
    attach = false;
    windows = [
      {
        helix = "${pkgs.helix}/bin/hx";
      }
      {
        git = "${pkgs.lazygit}/bin/lazygit";
      }
      {
        shell = "";
      }
    ];
  };
in
{
  home.file = {
    "${tmuxinatorBasePath}/${nixSessionFileName}".text = "${nixSessionFilePath}";
    "${tmuxinatorBasePath}/${kattisSessionFileName}".text = "${kattisSessionFilePath}";
  };

  systemd.user.services.tmuxinator-auto-start = {
    Unit = {
      description = "Start tmux with tmuxinator specified sessions on login.";
    };

    Install = {
      wantedBy = [ "default.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = ''
        ls ${tmuxinatorBasePath} | ${pkgs.findutils}/bin/xargs -I {} ${pkgs.tmuxinator}/bin/tmuxinator start -p ${tmuxinatorBasePath}/{}
      '';
      ExecStop = "${pkgs.tmux}/bin/tmux kill-server";
    };
  };
}

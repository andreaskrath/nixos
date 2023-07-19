{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    steam
    steam-run
  ];
  
  # setting up steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}


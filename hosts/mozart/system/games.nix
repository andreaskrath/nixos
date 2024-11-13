{pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    lutris
    wine
    winetricks
    wowup-cf
    lime3ds
    melonDS
    mgba
  ];

  hardware.xpadneo.enable = true;
}

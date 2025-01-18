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
  ];

  hardware.xpadneo.enable = true;
}

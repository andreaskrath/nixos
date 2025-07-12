{
  pkgs,
  homeModules,
  ...
}: {
  imports = [
    ./i3.nix
    ./git.nix
    "${homeModules}/polybar.nix"
    "${homeModules}/i3.nix"
  ];

  krath.home = {
    polybar = {
      enable = true;
      enableDownload = true;
      enableUpload = true;

      monitors = ["DP-4" "DP-2"];
      fileSystems = ["/" "/mnt/external"];

      primaryBarWidth = "98.4%";
      xOffset = "0.8%";

      thermalZone = 2;
      thermalType = "x86_pkg_temp";
    };

    i3 = {
      enable = true;
      extraAssigns = {
        "4" = [
          {class = "^steam$";}
          {class = "^Lutris$";}
          {class = "^lutris$";}
          {class = "^battle.net.exe$";}
        ];
      };
      extraStartup = [
        {
          command = ''
            ${pkgs.xorg.xinput}/bin/xinput set-prop "pointer:Logitech G903 LS" "libinput Middle Emulation Enabled" 0
          '';
          always = true;
          notification = false;
        }
      ];
    };
  };
}

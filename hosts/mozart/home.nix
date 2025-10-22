{
  pkgs,
  homeModules,
  ...
}: {
  imports = [
    "${homeModules}/git.nix"
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

      bindWorkspaces = {
        DP-2 = ["9" "10"];
        DP-4 = ["1" "2" "3" "4" "5" "6" "7" "8"];
      };
    };

    git = {
      enable = true;
      allowedSignersKey = "AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W";
    };
  };
}

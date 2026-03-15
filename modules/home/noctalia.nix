{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # Options are not documented, but you can find them with:
  # `noctalia-shell ipc call state all | jq .settings`
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      dock = {
        enabled = false;
      };

      bar = {
        density = "compact";
        position = "top";
        widgets = {
          left = [
            {
              id = "Workspace";
              labelMode = "name";
              characterCount = "10";
              hideUnoccupied = true;
            }
            {id = "ActiveWindow";}
          ];

          center = [
            {id = "Clock";}
          ];

          right = [
            {id = "Volume";}
            {id = "Tray";}
            {id = "NotificationHistory";}
          ];
        };
      };
    };
  };
}

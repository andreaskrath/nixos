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

      colorSchemes = {
        predefinedScheme = "Gruvbox";
      };

      bar = {
        position = "top";
        fontScale = 1.25;
        widgets = {
          left = [
            # Control Center
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }

            # Workspaces
            {
              id = "Workspace";
              labelMode = "name";
              characterCount = "10";
              hideUnoccupied = true;
              pillSize = 1.0;
              enableScrollWheel = false;
              unfocusedOpacity = 0.5;
            }

            # Media Player
            {
              id = "MediaMini";
              hideWhenIdle = true;
              maxWidth = 500;
              useFixedWidth = true;
              showVisualizer = true;
            }
          ];

          center = [
            # Clock
            {
              id = "Clock";
            }
          ];

          right = [
            # System Monitor
            {
              id = "SystemMonitor";
              compactMode = false;
              showMemoryAsPercent = true;
            }

            # Audio Controls
            {
              id = "Volume";
            }

            # Notification Hub
            {
              id = "NotificationHistory";
            }

            # System Tray
            {
              id = "Tray";
            }
          ];
        };
      };
    };
  };
}

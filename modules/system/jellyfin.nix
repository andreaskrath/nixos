{
  config,
  lib,
  ...
}: let
  cfg = config.krath.system.jellyfin;
in {
  options.krath.system.jellyfin = {
    enable = lib.mkEnableOption "Enable Jellyfin module.";
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}

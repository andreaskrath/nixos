{pkgs, ...}: {
  # Allow HTTP from WireGuard
  networking.firewall.interfaces.wg0.allowedTCPPorts = [80];

  services.nginx = {
    enable = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {
      "datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        locations."/".proxyPass = "http://127.0.0.1:8080";
      };

      "www.datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        globalRedirect = "datamagikeren.dk";
      };

      "hooks.datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        locations."/".proxyPass = "http://127.0.0.1:9000";
      };

      "recipes.datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        locations."/" = {
          proxyPass = "http://127.0.0.1:9080";
          basicAuthFile = pkgs.writeText ".htpasswd" ''
            krath:$apr1$wmxqi036$CWdRdI19fzj7KASXP1/9e0
          '';
        };
      };

      "initiative.datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        locations."/" = {
          proxyPass = "http://127.0.0.1:5173";
          basicAuthFile = pkgs.writeText ".htpasswd" ''
            krath:$apr1$s3jhxr0b$zfrjRZL4LwexHW1B92YhU1
          '';
        };
      };

      "torrents.datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        locations."/".proxyPass = "http://127.0.0.1:42069";
      };

      "jellyfin.datamagikeren.dk" = {
        listen = [{addr = "10.100.0.2"; port = 80;}];
        locations."/".proxyPass = "http://127.0.0.1:8096";
      };
    };
  };
}

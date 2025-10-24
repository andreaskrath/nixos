{pkgs, ...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    clientMaxBodySize = "500m";

    virtualHosts = {
      "datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:8080";
        };
      };

      "www.datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "datamagikeren.dk";
      };

      "hooks.datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:9000";
        };
      };

      "recipes.datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;

        locations."/" = {
          proxyPass = "http://127.0.0.1:9080";
          basicAuthFile = pkgs.writeText ".htpasswd" ''
            krath:$apr1$wmxqi036$CWdRdI19fzj7KASXP1/9e0
          '';
        };
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "andreas.krath@gmail.com";
    };
  };
}

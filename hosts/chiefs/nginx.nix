{...}: {
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
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "andreas.krath@gmail.com";
    };
  };
}

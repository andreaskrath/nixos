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
          return = "307 https://www.youtube.com/watch?v=dQw4w9WgXcQ"; # rick roll for the time being
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

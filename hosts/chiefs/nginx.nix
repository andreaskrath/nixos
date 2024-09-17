{...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    clientMaxBodySize = "500m";

    virtualHosts = {
      "www.datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;
      };

      "datamagikeren.dk" = {
        forceSSL = true;
        enableACME = true;
        globalRedirect = "www.datamagikeren.dk";
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

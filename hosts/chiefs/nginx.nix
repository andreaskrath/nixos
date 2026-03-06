{config, ...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    clientMaxBodySize = "500m";

    virtualHosts = {
      "datamagikeren.dk" = {
        serverAliases = ["*.datamagikeren.dk"];
        forceSSL = true;
        useACMEHost = "datamagikeren.dk";
        locations."/".proxyPass = "http://10.100.0.2";
      };
    };
  };

  # Wildcard certificate for *.datamagikeren.dk
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "andreas.krath@gmail.com";
      dnsProvider = "cloudflare";
      environmentFile = config.age.secrets.cloudflare-api-key.path;
    };

    certs."datamagikeren.dk" = {
      domain = "datamagikeren.dk";
      extraDomainNames = ["*.datamagikeren.dk"];
      group = "nginx";
      dnsProvider = "cloudflare";
      environmentFile = config.age.secrets.cloudflare-api-key.path;
    };
  };
}

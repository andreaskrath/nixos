{config, ...}: {
  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;
    clientMaxBodySize = "500m";

    virtualHosts = {
      "krath.dev" = {
        serverAliases = ["*.krath.dev"];
        forceSSL = true;
        useACMEHost = "krath.dev";
        extraConfig = ''
          add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
        '';
        locations."/" = {
          proxyPass = "http://10.100.0.2";
          proxyWebsockets = true;
        };
      };
    };
  };

  # Wildcard certificate for *.krath.dev
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "certs@krath.dev";
      dnsProvider = "cloudflare";
      environmentFile = config.age.secrets.cloudflare-api-key.path;
    };

    certs."krath.dev" = {
      domain = "krath.dev";
      extraDomainNames = ["*.krath.dev"];
      group = "nginx";
      dnsProvider = "cloudflare";
      environmentFile = config.age.secrets.cloudflare-api-key.path;
    };
  };
}

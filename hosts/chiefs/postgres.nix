{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = ["dnd"];
    authentication = pkgs.lib.mkOverride 10 ''
      # type  database user_name address   auth_method
        local all      all                 trust
        host  all      all       0.0.0.0/0 trust
    '';

    settings = {
      listen_addresses = "*";
    };
  };
}

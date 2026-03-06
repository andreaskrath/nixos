{pkgs, ...}: {
  services.postgresql = {
    enable = true;
    ensureDatabases = ["dnd"];
    authentication = pkgs.lib.mkOverride 10 ''
      # type  database user_name address         auth_method
      local   all      all                       trust
      host    all      all        127.0.0.1/32   trust
      host    all      all        ::1/128        trust
    '';
  };
}

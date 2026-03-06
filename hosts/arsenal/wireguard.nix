{config, ...}: {
  networking.wireguard.interfaces.wg0 = {
    ips = ["10.100.0.2/24"];
    privateKeyFile = config.age.secrets.wg-private-key.path;

    peers = [
      {
        # chiefs
        publicKey = "ejnq5lp2fFqlG0DYYmkgXtX+bOuQw3r+L1l9Fvn32ns=";
        endpoint = "datamagikeren.dk:51820";
        allowedIPs = ["10.100.0.1/32"];
        persistentKeepalive = 25;
      }
    ];
  };
}

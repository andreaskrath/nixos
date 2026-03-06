{config, ...}: {
  networking.wireguard.interfaces.wg0 = {
    ips = ["10.100.0.1/24"];
    listenPort = 51820;
    privateKeyFile = config.age.secrets.wg-private-key.path;

    peers = [
      {
        # arsenal
        publicKey = "FP4sc7EStRhKNAVHGygMnuJYmU+Waj43MzjRNt4FTyQ=";
        allowedIPs = ["10.100.0.2/32"];
      }
    ];
  };

  networking.firewall.allowedUDPPorts = [51820];
}

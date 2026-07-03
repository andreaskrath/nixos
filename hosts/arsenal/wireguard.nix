{
  config,
  pkgs,
  ...
}: let
  # Hetzner VPS Public IP
  chiefsPublicIP = "95.217.161.174";
  # Home router
  homeGateway = "192.168.0.1";
in {
  networking.wireguard.interfaces.wg0 = {
    ips = ["10.100.0.2/24"];
    privateKeyFile = config.age.secrets.wg-private-key.path;

    # Mark WireGuard's UDP socket with Mullvad's own bypass fwmark so its
    # encrypted packets route via the main table (direct to chiefs) instead
    # of being sent through the Mullvad tunnel, avoiding a double tunnel.
    postSetup = "${pkgs.wireguard-tools}/bin/wg set wg0 fwmark 0x6d6f6c65";

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

  # Mullvad's kill switch (nftables, policy drop on input+output) blocks any
  # traffic not going through wg0-mullvad. These rules mark the WireGuard
  # handshake and data packets to/from chiefs with Mullvad's trusted conntrack
  # mark so both chains accept them. Runs before wireguard-wg0 starts so the
  # first handshake is already allowed through.
  systemd.services.wg-chiefs-mullvad-bypass = {
    description = "Allow wg0 tunnel to chiefs to bypass Mullvad kill switch";
    after = ["mullvad-daemon.service"];
    before = ["wireguard-wg0.service"];
    wantedBy = ["wireguard-wg0.service"];
    partOf = ["mullvad-daemon.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "wg-bypass-up" ''
        ${pkgs.iproute2}/bin/ip route replace ${chiefsPublicIP}/32 via ${homeGateway}

        # Flush and recreate cleanly to avoid duplicate rules on restart.
        ${pkgs.nftables}/bin/nft delete table inet excludeWg0 2>/dev/null || true
        ${pkgs.nftables}/bin/nft add table inet excludeWg0

        ${pkgs.nftables}/bin/nft add chain inet excludeWg0 excludeIncoming \
          '{ type filter hook input priority -100; policy accept; }'
        # 0x00000f41 = Mullvad's trusted conntrack mark (accepted by mullvad input/output chains).
        # 0x6d6f6c65 = "mole" — Mullvad's routing bypass fwmark.
        # Verify current values with: nft list table inet mullvad
        ${pkgs.nftables}/bin/nft add rule inet excludeWg0 excludeIncoming \
          ip saddr ${chiefsPublicIP} udp sport 51820 \
          ct mark set 0x00000f41 meta mark set 0x6d6f6c65

        ${pkgs.nftables}/bin/nft add chain inet excludeWg0 excludeOutgoing \
          '{ type route hook output priority -100; policy accept; }'
        ${pkgs.nftables}/bin/nft add rule inet excludeWg0 excludeOutgoing \
          ip daddr ${chiefsPublicIP} udp dport 51820 \
          ct mark set 0x00000f41 meta mark set 0x6d6f6c65
      '';
      ExecStop = pkgs.writeShellScript "wg-bypass-down" ''
        ${pkgs.nftables}/bin/nft delete table inet excludeWg0 2>/dev/null || true
        ${pkgs.iproute2}/bin/ip route del ${chiefsPublicIP}/32 via ${homeGateway} 2>/dev/null || true
      '';
    };
  };
}

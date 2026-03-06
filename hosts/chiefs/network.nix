{...}: {
  services.openssh.enable = true;
  services.openssh.openFirewall = true;

  users.users = {
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W andreas.krath+github@gmail.com" # desktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmQFlZI9ovaJXVgNv+c3hnLcN8z9ub1pzFSV/4dUeEQ andreas.krath+github@gmail.com" # laptop
    ];

    mahomes.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W andreas.krath+github@gmail.com" # desktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmQFlZI9ovaJXVgNv+c3hnLcN8z9ub1pzFSV/4dUeEQ andreas.krath+github@gmail.com" # laptop
    ];
  };

  # networking.firewall.enable = false;
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.allowedTCPPorts = [80 443];

  # enables ipv6
  networking.useDHCP = false;
  systemd.network = {
    enable = true;
    networks.hetzner = {
      name = "enp1s0";
      address = [
        "95.217.161.174/32"
        "2a01:4f9:c012:c75::1/64"
      ];

      gateway = [
        "fe80::1"
        "172.31.1.1"
      ];

      routes = [
        {Destination = "172.31.1.1";}
        {Destination = "fe80::1";}
      ];
    };
  };
}

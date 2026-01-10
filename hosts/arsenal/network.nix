{pkgs, ...}: {
  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  users.users = {
    root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W andreas.krath+github@gmail.com" # desktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmQFlZI9ovaJXVgNv+c3hnLcN8z9ub1pzFSV/4dUeEQ andreas.krath+github@gmail.com" # laptop
    ];

    henry.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W andreas.krath+github@gmail.com" # desktop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmQFlZI9ovaJXVgNv+c3hnLcN8z9ub1pzFSV/4dUeEQ andreas.krath+github@gmail.com" # laptop
    ];
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  # networking.firewall.allowedTCPPorts = [80 443 5432];
}

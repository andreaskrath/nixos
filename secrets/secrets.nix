let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEmQFlZI9ovaJXVgNv+c3hnLcN8z9ub1pzFSV/4dUeEQ";
  users = [desktop laptop];

  chiefs = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPII91UAVe89RTSQQ2TEKpBXzGGR2wHuXL9B3W/lwpG5";
  arsenal = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGz7X+1PGZxSI6LAN5T2PNw7AKEZzGs2ZT4B8YErDJjy";
  servers = [chiefs arsenal];
in {
  "cloudflare-api-key.age".publicKeys = users ++ servers;
}

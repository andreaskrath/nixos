{homeModules, ...}: {
  imports = [
    "${homeModules}/git.nix"
  ];

  programs.ssh = {
    enable = true;
    matchBlocks = {
      arsenal = {
        hostname = "192.168.0.158";
      };

      chiefs = {
        hostname = "datamagikeren.dk";
      };
    };
  };

  krath.home = {
    git = {
      enable = true;
      allowedSignersKey = "AAAAC3NzaC1lZDI1NTE5AAAAIJNjyEbOjbtKjrVjzEZo+3WWm/Z1TECQ4u80cRPnCv3W";
    };
  };
}

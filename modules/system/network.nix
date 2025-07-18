{...}: {
  hardware.bluetooth.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
    "1.0.0.1"
    "8.8.4.4"
  ];
  # Enable networking

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}

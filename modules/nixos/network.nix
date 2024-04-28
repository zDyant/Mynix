{ ... }:
{
  networking.hostName = "zdyant"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Sunshine configuration
  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 47984 47989 47990 48010 ];
  allowedUDPPortRanges = [
    { from = 47998; to = 48000; }
    { from = 8000; to = 8010; }
  ];
};

  services.zerotierone = {
    enable = true;
    joinNetworks = [ "e3918db483703b19" ];
  };

}

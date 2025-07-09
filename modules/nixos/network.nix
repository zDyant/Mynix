{ ... }:
{
  networking.hostName = "zdyant";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;
  
  networking.enableIPv6 = true;

  # Sunshine configuration
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3040 47984 47989 47990 48010 ];
    allowedUDPPorts = [ 9993 9994 ];
    allowedUDPPortRanges = [
      { from = 47998; to = 48000; }
      { from = 8000; to = 8010; }
    ];
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ 
      "a84ac5c10a7b57e4"
    ];
  };

  # Do not prevent Nix from building
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}

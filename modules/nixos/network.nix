{ ... }:
{
  imports = [
    ./nextdns.nix
  ];
  networking = {
    hostName = "zdyant";
    networkmanager.enable = true;
    enableIPv6 = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    firewall = {
      enable = true;
      # Sunshine configuration
      allowedTCPPorts = [ 3040 47984 47989 47990 48010 45555 11434];
      allowedUDPPorts = [ 9993 9994 ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48000; }
        { from = 8000; to = 8010; }
      ];
    };
  };

  services.zerotierone = {
    enable = true;
    joinNetworks = [ 
      "a84ac5c10a7b57e4"
    ];
  };

  services.myNextDNS = {
    enable = true;
  };

  # Do not prevent Nix from building
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}

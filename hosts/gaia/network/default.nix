{ ... }: {
  imports = [ ../nextdns ];
  networking = {
    networkmanager.enable = true;
    enableIPv6 = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 3040 11434 1342 1337 ];
      allowedUDPPorts = [ 9993 9994 ];
    };
  };

  services.tailscale = {
    enable = true;
    # openFirewall = true; # Not needed
    extraDaemonFlags = [ "--no-logs-no-support" ]; # No telemetry
  };

  services.myNextDNS = { enable = true; };

  # Stop preventing Nix from building
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}

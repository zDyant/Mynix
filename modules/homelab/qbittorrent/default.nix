{ config, lib, ... }:
let cfg = config.services.qbittorrent-custom;
in {
  options.services."qbittorrent-custom" = {
    enable = lib.mkEnableOption
      "Qbittorrent client (bound to a Wireguard VPN network)";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8112;
      description = "Qbittorrent bind address";
      example = 8080;
    };

  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 2832 ];
    # Die deluge
    services.qbittorrent = {
      enable = true;
      webuiPort = cfg.port;
      openFirewall = true;
    };
  };
}

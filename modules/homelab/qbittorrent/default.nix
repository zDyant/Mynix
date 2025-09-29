{ config, lib, pkgs, ... }:
let
  cfg = config.services.qbittorrent-custom;
  namespace = config.services.wireguard-netns.namespace;
in {
  options.services."qbittorrent-custom" = {
    enable = lib.mkEnableOption "Qbittorrent client (bound to a Wireguard VPN network)";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8112;
      description = "Qbittorrent bind address";
      example = 8080;
    };

  };

  config = lib.mkIf cfg.enable {
    # Die deluge
    services.qbittorrent = {
      enable = true;
      webuiPort = cfg.port;
      openFirewall = true;
    };

    # Connect to wireguard
    systemd = lib.mkIf config.services.wireguard-netns.enable {
      services.qbittorrent = {
        # description = "Service that will only have access to the wg0 interface";
        bindsTo = [ "netns@${namespace}.service" ];
        requires = [
          "network-online.target"
          "qbittorrent-proxy.service"
          "${namespace}.service"
        ];
        after = [ "${namespace}.service" ];
        serviceConfig.NetworkNamespacePath = "/var/run/netns/${namespace}";
      };

      sockets."qbittorrent-proxy" = {
        enable = true;
        description = "Socket for Proxy to qBittorrent WebUI";
        listenStreams = [ "${toString cfg.port}" ]; # Different port on main network
        wantedBy = [ "sockets.target" ];
      };

      services."qbittorrent-proxy" = {
        enable = true;
        description = "Proxy to qBittorrent WebUI in Network Namespace";
        requires = [ "qbittorrent.service" "qbittorrent-proxy.socket" ];
        after = [ "qbittorrent.service" "qbittorrent-proxy.socket" ];
        unitConfig.JoinsNamespaceOf = "qbittorrent.service";
        serviceConfig = {
          User = config.services.qbittorrent.user;
          Group = config.services.qbittorrent.group;
          ExecStart =
            "${pkgs.systemd}/lib/systemd/systemd-socket-proxyd 127.0.0.1:${toString cfg.port}";
          PrivateNetwork = "yes";
        };
      };
    };

  };
}

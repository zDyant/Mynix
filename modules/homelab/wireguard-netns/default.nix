{ pkgs, config, lib, ... }:
let
  cfg = config.services.wireguard-netns;
in {
  options.services.wireguard-netns = {
    enable = lib.mkEnableOption {
      description = "Enable Wireguard client network namespace";
    };

    namespace = lib.mkOption {
      type = lib.types.str;
      description = "Network namespace to be created";
      default = "wg_client";
      example = "vpn-custom";
    };

    configFile = lib.mkOption {
      type = lib.types.path;
      description =
        "Path to a file with Wireguard config (not a wg-quick one!)";
      example = lib.literalExpression ''
        pkgs.writeText "wg0.conf" '''
          [Interface]
          PrivateKey = <client's privatekey>

          [Peer]
          PublicKey = <server's publickey>
          Endpoint = <server's ip>:51820
        '''
      '';
    };
    privateIP = lib.mkOption {
      type = lib.types.str;
      description = "Private IP";
    };
    dnsIP = lib.mkOption {
      type = lib.types.str;
      description = "DNS Server IP";
      default = "1.1.1.1";
      example = "8.8.8.8";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services."netns@" = {
      description = "%I network namespace";
      before = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.iproute2}/bin/ip netns add %I";
        ExecStop = "${pkgs.iproute2}/bin/ip netns del %I";
      };
    };
    environment.etc."netns/${cfg.namespace}/resolv.conf".text = "nameserver ${cfg.dnsIP}";

    systemd.services.${cfg.namespace} = {
      description = "Wireguard ${cfg.namespace} network interface";
      bindsTo = [ "netns@${cfg.namespace}.service" ];
      requires = [ "network-online.target" ];
      after = [ "netns@${cfg.namespace}.service" "network-online.target" ];
      # wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        Restart = "on-failure";
        RemainAfterExit = true;
        ExecStartPre = with pkgs;
          writers.writeBash "wg-cleanup" ''
            set -e
            # Removing 2>/dev/null results in error (?)
            ${iproute2}/bin/ip link del wg0 2>/dev/null || true
            ${iproute2}/bin/ip -n ${cfg.namespace} link del wg0 2>/dev/null || true
          '';
        ExecStart = with pkgs;
          writers.writeBash "wg-up" ''
            set -e
            ${iproute2}/bin/ip link add wg0 type wireguard
            ${iproute2}/bin/ip link set wg0 netns ${cfg.namespace}
            ${iproute2}/bin/ip -n ${cfg.namespace} address add ${cfg.privateIP} dev wg0
            ${iproute2}/bin/ip netns exec ${cfg.namespace} \
            ${wireguard-tools}/bin/wg setconf wg0 ${cfg.configFile}
            ${iproute2}/bin/ip -n ${cfg.namespace} link set wg0 up
            ${iproute2}/bin/ip -n ${cfg.namespace} link set lo up
            ${iproute2}/bin/ip -n ${cfg.namespace} route add default dev wg0
          '';
        ExecStop = with pkgs;
          writers.writeBash "wg-down" ''
            set -e
            ${iproute2}/bin/ip -n ${cfg.namespace} route del default dev wg0
            ${iproute2}/bin/ip -n ${cfg.namespace} link del wg0
            ${iproute2}/bin/ip -n ${cfg.namespace} addr flush dev wg0
          '';
        # unitConfig.StartLimitIntervalSec = 0;
      };
    };
  };
}

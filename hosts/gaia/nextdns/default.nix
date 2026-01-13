{ config, lib, ... }:

let
  cfg = config.services.myNextDNS;
in
{
  options.services.myNextDNS = {
    enable = lib.mkEnableOption "Custom NextDNS configuration";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.nextdns_id = { };

    sops.templates."resolved.conf" = {
      content = ''
        [Resolve]
        DNS=45.90.28.0#${config.sops.placeholder.nextdns_id}.dns.nextdns.io
        DNS=2a07:a8c0::#${config.sops.placeholder.nextdns_id}.dns.nextdns.io
        DNS=45.90.30.0#${config.sops.placeholder.nextdns_id}.dns.nextdns.io
        DNS=2a07:a8c1::#${config.sops.placeholder.nextdns_id}.dns.nextdns.io
        DNSOverTLS=yes
      '';
      path = "/run/systemd/resolved.conf.d/nextdns.conf";
      owner = "root";
      group = "systemd-resolve";
      restartUnits = [ "systemd-resolved.service" ];
      mode = "0440";
    };
    services.resolved.enable = true;
    services.resolved.dnsovertls = "true";

    # prevent switching back to default dns
    networking.networkmanager.dns = lib.mkDefault "systemd-resolved";
    services.resolved.domains = [ "~." ];
  };
}

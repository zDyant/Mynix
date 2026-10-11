{
  lib,
  secrets,
  ...
}: {
  environment.etc."systemd/resolved.conf.d/nextdns.conf" = {
    text = ''
      [Resolve]
      DNS=45.90.28.0#${secrets.nextdns.moderate}.dns.nextdns.io
      DNS=2a07:a8c0::#${secrets.nextdns.moderate}.dns.nextdns.io
      DNS=45.90.30.0#${secrets.nextdns.moderate}.dns.nextdns.io
      DNS=2a07:a8c1::#${secrets.nextdns.moderate}.dns.nextdns.io
      DNSOverTLS=yes
    '';
    user = "root";
    group = "systemd-resolve";
    mode = "0440";
  };

  services.resolved.enable = true;
  services.resolved.settings.Resolve.DNSOverTLS = "true";

  # prevent switching back to default dns
  networking.networkmanager.dns = lib.mkDefault "systemd-resolved";
  services.resolved.settings.Resolve.Domains = ["~."];
}

{ config, lib, ... }:
{
  sops.secrets.cloudflared-token = { };

  # WARN: services.cloudflared is broken
  # WARN: https://github.com/NixOS/nixpkgs/issues/370185
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      cloudflared = {
        image = "cloudflare/cloudflared:2025.9.1";
        autoStart = true;
        cmd = [ "tunnel" "--no-autoupdate" "run" ];
        volumes = [ "/opt/cloudflared/config:/etc/cloudflared" ];
        environmentFiles = [ config.sops.secrets.cloudflared-token.path ];
        extraOptions = [ "--network=host" ];
      };
    };
  };

  # WARN: Avoid: failed to sufficiently increase receive buffer size
  # https://github.com/quic-go/quic-go/wiki/UDP-Buffer-Sizes
  boot.kernel.sysctl."net.core.rmem_max" = lib.mkDefault 7500000;
  boot.kernel.sysctl."net.core.wmem_max" = lib.mkDefault 7500000;

}

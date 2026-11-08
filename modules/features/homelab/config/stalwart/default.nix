{
  config,
  lib,
  ...
}: let
  inherit (config) homelab;
  cfg = homelab.services.stalwart;
  hostname = "mail.${homelab.domain}";
in {
  options.homelab.services.stalwart = {
    enable = lib.mkEnableOption "Stalwart mail server";
    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "Loopback HTTP listener port for Stalwart's admin and JMAP endpoint";
    };
  };

  config = lib.mkIf (homelab.enable && cfg.enable) {
    assertions = [
      {
        assertion = homelab.domain != null;
        message = "Stalwart requires homelab.domain to be set";
      }
    ];

    services.stalwart = {
      enable = true;
      stateVersion = "26.11";
      openFirewall = false;
      credentials = {
        "mail-cert.pem" = "/var/lib/acme/${hostname}/fullchain.pem";
        "mail-key.pem" = "/var/lib/acme/${hostname}/key.pem";
      };
      settings = {
        server.hostname = hostname;
        server.listener = {
          smtp = {
            bind = ["0.0.0.0:25"];
            protocol = "smtp";
          };
          submissions = {
            bind = ["0.0.0.0:465"];
            protocol = "smtp";
            tls.implicit = true;
          };
          submission = {
            bind = ["0.0.0.0:587"];
            protocol = "smtp";
            tls.implicit = false;
          };
          imaps = {
            bind = ["0.0.0.0:993"];
            protocol = "imap";
            tls.implicit = true;
          };
          http = {
            bind = ["127.0.0.1:${toString cfg.port}"];
            protocol = "http";
          };
        };
        server.tls = {
          enable = true;
          certificate = "default";
        };
        certificate.default = {
          cert = "%{file:/run/credentials/stalwart.service/mail-cert.pem}%";
          default = true;
          private-key = "%{file:/run/credentials/stalwart.service/mail-key.pem}%";
        };
        lookup.default.hostname = hostname;
      };
    };

    security.acme.certs.${hostname} = {
      webroot = "/var/lib/acme/acme-challenge";
      reloadServices = ["stalwart.service"];
    };
    services.nginx.virtualHosts.${hostname} = {
      enableACME = true;
      forceSSL = true;
      extraConfig = ''
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header Referrer-Policy "strict-origin-when-cross-origin" always;
      '';
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString cfg.port}";
        proxyWebsockets = true;
      };
    };
    systemd.services.stalwart = {
      requires = ["acme-${hostname}.service"];
      after = ["acme-${hostname}.service"];
    };

    networking.firewall.allowedTCPPorts = [25 465 587 993];
  };
}

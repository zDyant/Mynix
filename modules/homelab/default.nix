{
  config,
  lib,
  ...
}: let
  cfg = config.homelab;
  securityHeaders = ''
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
  '';
  mkProxyVHost = {
    host,
    port,
    websocket ? false,
    extraConfig ? {},
  }: {
    "${host}.${cfg.domain}" =
      {
        enableACME = true;
        forceSSL = true;

        extraConfig = ''
          ${securityHeaders}
        '';
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString port}";
          proxyWebsockets = websocket;
          extraConfig = lib.optionalString (host == "hister") "client_max_body_size 100m;";
        };
      }
      // extraConfig;
  };

  enabledProxyVHosts =
    lib.mkMerge
    (lib.mapAttrsToList (
        host: websocket:
          lib.mkIf cfg.services.${host}.enable (mkProxyVHost {
            inherit host websocket;
            inherit (cfg.services.${host}) port;
          })
      ) {
        hister = true;
        glance = false;
        openmonetis = false;
        ollama = false;
        kutt = true;
        karakeep = false;
        n8n = true;
      });
in {
  imports = lib.fs.scanPaths ./.;

  options.homelab = {
    enable = lib.mkEnableOption "Enable Homelab services and configuration";
    domain = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Public domain for HTTPS access to the services; null disables the reverse proxy";
      example = "zdyant.com";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.domain != null) {
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];

    security.acme.acceptTerms = true;
    security.acme.defaults.email = "zdyant@pm.me";

    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts = enabledProxyVHosts;
    };
  };
}

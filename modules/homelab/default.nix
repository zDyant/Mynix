{
  config,
  lib,
  ...
}: let
  cfg = config.homelab;
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
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        '';
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString port}";
          proxyWebsockets = websocket;
        };
      }
      // extraConfig;
  };

  enabledProxyVHosts = lib.mkMerge [
    (lib.mkIf cfg.services.glance.enable (mkProxyVHost {
      host = "glance";
      port = cfg.services.glance.port;
    }))
    (lib.mkIf cfg.services.openmonetis.enable (mkProxyVHost {
      host = "openmonetis";
      port = cfg.services.openmonetis.port;
    }))
    (lib.mkIf cfg.services.ollama.enable (mkProxyVHost {
      host = "ollama";
      port = cfg.services.ollama.port;
    }))
    (lib.mkIf cfg.services.kutt.enable (mkProxyVHost {
      host = "kutt";
      port = cfg.services.kutt.port;
      websocket = true;
    }))
  ];
in {
  imports = lib.fs.scanPaths ./.;

  options.homelab = {
    enable = lib.mkEnableOption "Enable Homelab services and configuration";
    domain = lib.mkOption {
      type = lib.types.str;
      description = "Domain used to access the services";
      example = "zdyant.com";
    };
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [80 443];

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

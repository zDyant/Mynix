{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services.ezbookkeeping;
in {
  options.homelab.services.ezbookkeeping = {
    enable = lib.mkEnableOption "Ezbookkeeping configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Ezbookkeeping bind address";
      default = 45559;
      example = 8080;
    };
    ebkKey = lib.mkOption {
      type = lib.types.path;
      description =
        "Key used to sign authentication tokens. Use a long random string";
    };
  };

  # https://ezbookkeeping.mayswind.net/configuration#mcp-model-context-protocol
  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers = {
      containers = {
        ezbookkeeping = {
          image = "mayswind/ezbookkeeping";
          autoStart = true;
          ports = [ "${toString cfg.port}:8080" ];
          volumes = [
            "/var/log/ezbookkeeping:/ezbookkeeping/log"
            "/var/lib/ezbookkeeping/storage:/ezbookkeeping/storage"
            "/var/lib/ezbookkeeping/data:/ezbookkeeping/data"
          ];
          environment = {
            EBK_SERVER_DOMAIN = homelab.domain;
            EBK_SERVER_ROOT_URL = "https://ezbookkeeping.${homelab.domain}";
            EBK_SERVER_ENABLE_GZIP = "true";
            EBK_LOG_MODE = "file";
          };
          environmentFiles = [ cfg.ebkKey ];
        };
      };
    };
    systemd.tmpfiles.rules = [
      "d /var/log/ezbookkeeping         0755 1000 1000 -"
      "d /var/lib/ezbookkeeping/storage 0755 1000 1000 -"
      "d /var/lib/ezbookkeeping/data    0755 1000 1000 -"
    ];
  };

}


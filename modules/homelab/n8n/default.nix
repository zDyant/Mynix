{
  config,
  lib,
  pkgs,
  ...
}: let
  homelab = config.homelab;
  name = "n8n";
  cfg = homelab.services.${name};
in {
  options.homelab.services.${name} = {
    enable = lib.mkEnableOption "n8n configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "n8n bind port";
      default = 5678;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.n8n = {
      enable = true;
      environment = {
        N8N_PORT = cfg.port;
        WEBHOOK_URL = "https://${name}.${homelab.domain}";
      };
    };

    systemd.services.n8n.path = with pkgs; [
      nodejs
      python3
    ];
  };
}

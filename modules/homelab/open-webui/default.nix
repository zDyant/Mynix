{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services."open-webui";
in {
  options.homelab.services."open-webui" = {
    enable = lib.mkEnableOption "Custom Open-webui configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Open-webui bind address";
      default = 45555;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.open-webui = {
      enable = true;
      openFirewall = true;
      port = 45555;
    };

  };
}


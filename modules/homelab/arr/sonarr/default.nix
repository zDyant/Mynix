{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services."sonarr";
in {
  options.homelab.services."sonarr" = {
    enable = lib.mkEnableOption "Custom Sonarr configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Sonarr bind address";
      default = 8989;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.sonarr = {
      enable = true;
      openFirewall = true;

      settings = {
        server = {
          port = cfg.port;
        };
      };
    };
  };
}

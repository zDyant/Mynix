{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services."prowlarr";
in {
  options.homelab.services."prowlarr" = {
    enable = lib.mkEnableOption "Custom Prowlarr configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Prowlarr bind address";
      default = 9696;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.prowlarr = {
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



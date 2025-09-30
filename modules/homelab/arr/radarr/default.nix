{ config, lib, ... }:
let
  cfg = config.services."radarr-custom";
in {
  options.services."radarr-custom" = {
    enable = lib.mkEnableOption "Custom Radarr configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Radarr bind address";
      default = 7878;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.radarr = {
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


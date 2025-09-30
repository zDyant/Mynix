{ config, lib, ... }:
let
  cfg = config.services."sonarr-custom";
in {
  options.services."sonarr-custom" = {
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

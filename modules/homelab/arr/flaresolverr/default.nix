{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services."flaresolverr";
in {
  options.homelab.services."flaresolverr" = {
    enable = lib.mkEnableOption "Custom Flaresolverr configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Flaresolverr bind address";
      default = 8191;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.flaresolverr = {
      enable = true;
      openFirewall = true;
      port = cfg.port;
    };
  };
}


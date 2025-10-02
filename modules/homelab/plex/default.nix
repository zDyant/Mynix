{ lib, config, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services.plex;
in {
  options.homelab.services.plex = {
    enable = lib.mkEnableOption "Custom Plex configuration";
  };

  config = lib.mkIf cfg.enable {
    services.plex = {
      enable = true;
      # :32400
      openFirewall = true;
    };
  };

}

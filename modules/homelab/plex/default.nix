{ lib, config, ... }:
let
  cfg = config.services.plex-custom;
in {
  options.services.plex-custom = {
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

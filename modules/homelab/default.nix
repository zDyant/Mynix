{ config, lib, ... }:
let
  cfg = config.homelab;
in
{
  options.homelab = {
    enable = lib.mkEnableOption "Enable Homelab services and configuration";
    timeZone = lib.mkOption {
      default = "America/Sao_Paulo";
      type = lib.types.str;
      description = "Time zone used by the services";
      example = "Europe/Berlin";
    };
    domain = lib.mkOption {
      type = lib.types.str;
      description = "Domain used to access the services";
      example = "zdyant.com";
    };
    cloudflaredToken = lib.mkOption {
      type = lib.types.path;
      description = "Cloudflared tunnel used to expose services";
      example = "/run/secrets/cloudflared-tunnel";
    };
  };


  imports = [
    ./glance
    ./plex
    ./arr
    ./cloudflared
    ./qbittorrent
    ./open-webui
    ./ollama
    ./kutt
    ./ezbookkeeping
  ];

}

{ config, ... }:
{
  imports = [ ../homelab/default.nix ];

  sops.secrets.cloudflared-token = { };
  sops.secrets.kutt-token = { };
  homelab = {
    enable = true;
    domain = "zdyant.xyz";
    cloudflaredToken = config.sops.secrets.cloudflared-token.path;

    services = {
      glance.enable = true;
      qbittorrent.enable = true;
      plex.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      flaresolverr.enable = true;
      open-webui.enable = true;
      ollama.enable = true;
      kutt = {
        enable = true;
        jwtToken = config.sops.secrets.kutt-token.path;
      };
    };
  };
}

{ config, ... }: {
  imports = [ ../homelab/default.nix ];

  sops.secrets.cloudflared-token = { };
  sops.secrets.kutt-token = { };
  sops.secrets.ebk-key = { };
  homelab = {
    enable = true;
    domain = "zdyant.xyz";
    cloudflaredToken = config.sops.secrets.cloudflared-token.path;

    services = {
      glance.enable = true;
      open-webui.enable = true;
      ollama.enable = true;
      kutt = {
        enable = true;
        jwtToken = config.sops.secrets.kutt-token.path;
      };
      ezbookkeeping = {
        enable = true;
        ebkKey = config.sops.secrets.ebk-key.path;
      };
    };
  };
}

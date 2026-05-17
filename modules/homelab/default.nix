{
  config,
  lib,
  ...
}: let
  cfg = config.homelab;
in {
  imports = lib.fs.scanPaths ./.;

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
  # networking.firewall.allowedTCPPorts = [80 443];
  # services.nginx = {
  #   enable = true;
  #   virtualHosts.localhost = {
  #     locations."/" = {
  #       return = "200 '<html><body>It works</body></html>'";
  #       extraConfig = ''
  #         default_type text/html;
  #       '';
  #     };
  #   };
  # };
  # security.acme = {
  #   acceptTerms = true;
  #   # Optional: You can configure the email address used with Let's Encrypt.
  #   # This way you get renewal reminders (automated by NixOS) as well as expiration emails.
  #   defaults.email = "gabriel@zdyant.com";
  # };
}

{
  config,
  lib,
  ...
}: let
  homelab = config.homelab;
  name = "karakeep";
  cfg = homelab.services.${name};
in {
  options.homelab.services.${name} = {
    enable = lib.mkEnableOption "Karakeep configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Karakeep bind address";
      default = 45555;
      example = 8080;
    };
    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      description = "Optional environment file for Karakeep secrets and settings";
      default = null;
      example = "/var/lib/karakeep/secrets.env";
    };
  };

  config = lib.mkIf cfg.enable {
    services.karakeep = {
      enable = true;
      inherit (cfg) environmentFile;

      extraEnvironment = {
        PORT = toString cfg.port;
        NEXTAUTH_URL = "https://${name}.${homelab.domain}";
      };
    };
  };
}

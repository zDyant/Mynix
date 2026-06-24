{
  config,
  lib,
  secrets,
  ...
}: let
  homelab = config.homelab;
  cfg = homelab.services."kutt";
in {
  options.homelab.services."kutt" = {
    enable = lib.mkEnableOption "Custom Kutt configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Kutt bind address";
      default = 3000;
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers = {
      containers = {
        kutt = {
          image = "kutt/kutt:main";
          autoStart = true;
          ports = ["127.0.0.1:${toString cfg.port}:3000"];
          volumes = [
            "/var/lib/kutt/db_data_sqlite:/var/lib/kutt"
            "/var/lib/kutt/custom:/kutt/custom"
          ];
          environment = {
            DB_FILENAME = "/var/lib/kutt/data.sqlite";
            TRUST_PROXY = "true";
            SITE_NAME = "zdyant";
            DEFAULT_DOMAIN = homelab.domain;
            JWT_SECRET = secrets.docker.JWT_SECRET;
          };
        };
      };
    };
  };
}

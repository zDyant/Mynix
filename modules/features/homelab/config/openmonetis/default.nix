{
  inputs,
  config,
  lib,
  secrets,
  ...
}: let
  homelab = config.homelab;
  cfg = homelab.services.openmonetis;
  name = "openmonetis";
  dbContainer = "${name}-db";
in {
  options.homelab.services.${name} = {
    enable = lib.mkEnableOption "Openmonetis configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Openmonetis bind address";
      default = 45557;
      example = 8080;
    };
  };

  imports = [inputs.mix-nix.nixosModules.oci-stacks];

  config = lib.mkIf (homelab.enable && cfg.enable) {
    virtualisation.oci-stacks.${name} = {
      containers = {
        ${dbContainer} = {
          image = "postgres:16-alpine";
          autoStart = true;
          extraOptions = [
            "--network=${name}"
            "--network-alias=${dbContainer}"
          ];
          volumes = [
            "/var/lib/${name}/postgres:/var/lib/postgresql/data"
          ];
        };

        ${name} = {
          image = "felipegcoutinho/openmonetis:main";
          autoStart = true;
          ports = ["127.0.0.1:${toString cfg.port}:3000"];
          dependsOn = [dbContainer];
          extraOptions = [
            "--network=${name}"
            "--network-alias=${name}"
          ];
          volumes = [
            "/var/lib/${name}"
          ];
          environment = {
            "BETTER_AUTH_SECRET" = secrets.docker.BETTER_AUTH_SECRET;
            "DATABASE_URL" = secrets.docker.OPENMONETIS_DB;
            "BETTER_AUTH_URL" =
              if homelab.domain != null
              then "https://${name}.${homelab.domain}"
              else "http://localhost:${toString cfg.port}";
            "DISABLE_SIGNUP" = "true"; # opcional: true bloqueia novos cadastros
          };
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/${name} 0755 root root -"
      "d /var/lib/${name}/postgres 0700 70 70 -"
    ];
  };
}

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) homelab;
  cfg = homelab.services.openmonetis;
  name = "openmonetis";
  dbContainer = "${name}-db";
in {
  options.homelab.services.${name} = {
    enable = lib.mkEnableOption "Openmonetis configuration";
    environmentFile = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/openmonetis/app.env";
      description = "Runtime environment file containing application secrets";
    };
    postgresEnvironmentFile = lib.mkOption {
      type = lib.types.str;
      default = "/var/lib/openmonetis/postgres.env";
      description = "Runtime environment file containing PostgreSQL initialization credentials";
    };
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
          environmentFiles = [cfg.postgresEnvironmentFile];
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
          environmentFiles = [cfg.environmentFile];
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
            "BETTER_AUTH_URL" =
              if homelab.domain != null
              then "https://${name}.${homelab.domain}"
              else "http://localhost:${toString cfg.port}";
            "DISABLE_SIGNUP" = "true"; # opcional: true bloqueia novos cadastros
          };
        };
      };
    };

    systemd.services."docker-${name}".preStart = lib.mkAfter ''
      for attempt in $(seq 1 60); do
        if ${pkgs.docker}/bin/docker exec ${dbContainer} sh -c 'pg_isready -h 127.0.0.1 -U "$POSTGRES_USER" -d "$POSTGRES_DB"' >/dev/null 2>&1; then
          exit 0
        fi
        sleep 2
      done
      echo "PostgreSQL did not become ready within 120 seconds" >&2
      exit 1
    '';

    systemd.tmpfiles.rules = [
      "d /var/lib/${name} 0755 root root -"
      "d /var/lib/${name}/postgres 0700 70 70 -"
      "z ${cfg.environmentFile} 0600 root root -"
      "z ${cfg.postgresEnvironmentFile} 0600 root root -"
    ];
  };
}

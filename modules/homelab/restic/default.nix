{
  config,
  lib,
  pkgs,
  ...
}: let
  homelab = config.homelab;
  name = "restic";
  cfg = homelab.services.${name};
  serviceBackupPaths =
    lib.optionals homelab.services.glance.enable ["/var/lib/glance"]
    ++ lib.optionals homelab.services.karakeep.enable ["/var/lib/karakeep"]
    ++ lib.optionals homelab.services.kutt.enable ["/var/lib/kutt"]
    ++ lib.optionals homelab.services.openmonetis.enable ["/var/lib/openmonetis"];
  stoppedServices =
    lib.optionals homelab.services.glance.enable [
      "glance.service"
    ]
    ++ lib.optionals homelab.services.karakeep.enable [
      "karakeep-browser.service"
      "karakeep-workers.service"
      "karakeep-web.service"
    ]
    ++ lib.optionals homelab.services.kutt.enable [
      "docker-kutt.service"
    ]
    ++ lib.optionals homelab.services.openmonetis.enable [
      "docker-openmonetis.service"
      "docker-openmonetis-db.service"
    ];
  restartServices = lib.reverseList stoppedServices;
in {
  options.homelab.services.${name} = {
    enable = lib.mkEnableOption "Restic backups";

    repository = lib.mkOption {
      type = lib.types.str;
      description = "Restic repository URL";
      example = "sftp:user@example.com:/backups/hephaestus";
    };

    passwordFile = lib.mkOption {
      type = lib.types.path;
      description = "File containing the Restic repository password";
      example = "/run/secrets/restic-password";
    };

    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Optional environment file for repository credentials";
      example = "/run/secrets/restic.env";
    };

    rcloneConfigFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Optional rclone config file to use for rclone repositories";
      example = "/root/.config/rclone/rclone.conf";
    };

    paths = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
      description = "Additional paths to include in the backup";
    };

    exclude = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "node_modules"
        ".pre-commit-config.yaml"
        "*.drv"
        "result"
        "*.py?"
        "__pycache__/"
        ".venv/"
        "*.tmp"
      ];
      description = "Patterns to exclude from the backup";
      example = [
        "/var/lib/*/cache"
        "*.tmp"
      ];
    };

    extraOptions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra extended options passed to restic with --option";
      example = [
        "rclone.connections=4"
        "rclone.transfers=4"
      ];
    };

    timerConfig = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        OnCalendar = "daily";
        Persistent = "true";
      };
      description = "systemd timer configuration for the backup job";
    };

    pruneOpts = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
      ];
      description = "Restic forget/prune retention options";
    };

    initialize = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Initialize the repository when it does not exist";
    };
  };

  config = lib.mkIf cfg.enable {
    services.restic.backups.${name} = {
      inherit
        (cfg)
        environmentFile
        exclude
        initialize
        passwordFile
        pruneOpts
        rcloneConfigFile
        repository
        timerConfig
        ;
      paths = serviceBackupPaths ++ cfg.paths;
      backupPrepareCommand = lib.mkIf (stoppedServices != []) ''
        ${pkgs.systemd}/bin/systemctl stop ${lib.escapeShellArgs stoppedServices}
      '';
      backupCleanupCommand = lib.mkIf (restartServices != []) ''
        ${pkgs.systemd}/bin/systemctl start ${lib.escapeShellArgs restartServices}
      '';
      extraOptions =
        [
          "rclone.program=${lib.getExe pkgs.rclone}"
        ]
        ++ cfg.extraOptions;
    };
  };
}

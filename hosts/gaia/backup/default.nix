{
  lib,
  pkgs,
  ...
}: let
  copyTargets = [
    {
      source = "/repos";
      destination = "filen-remote:/gaia/repos";
    }
    {
      source = "/home/zdyant/important";
      destination = "filen-remote:/gaia/important";
    }
    {
      source = "/home/zdyant/.config/nvim";
      destination = "filen-remote:/gaia/nvim";
    }
  ];
in {
  systemd.services.rclone-cloud-copy = {
    description = "Copy to Filen";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Nice = 10;
      IOSchedulingClass = "best-effort";
      IOSchedulingPriority = 7;
    };
    path = [pkgs.rclone];
    script = ''
      common_args=(
        --config /home/zdyant/.config/rclone/rclone.conf
        --create-empty-src-dirs
        --links
        --disable-http2
        --max-connections 4
        --tpslimit 4
        --tpslimit-burst 4
        --transfers 2
        --checkers 2
        --retries 8
        --retries-sleep 30s
        --low-level-retries 20
        --exclude node_modules/**
        --exclude .git/**
        --exclude result
        --exclude '*.tmp'
        --exclude __pycache__/**
        --exclude .venv/**
      )

      ${lib.concatMapStringsSep "\n" (target: ''
          rclone copy ${target.source} ${target.destination} "''${common_args[@]}"
        '')
        copyTargets}
    '';
  };

  systemd.timers.rclone-cloud-copy = {
    description = "Daily Filen file copy";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "30m";
      Unit = "rclone-cloud-copy.service";
    };
  };
}

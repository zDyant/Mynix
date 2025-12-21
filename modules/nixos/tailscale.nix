{ pkgs, config, ... }:
{
  services.tailscale = {
    enable = true;
    # openFirewall = true; # Not needed
    extraDaemonFlags = ["--no-logs-no-support"]; # No telemetry
  };
}

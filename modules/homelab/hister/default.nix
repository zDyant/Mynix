{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (config) homelab;
  name = "hister";
  cfg = homelab.services.${name};
  allowRules = pkgs.writeText "hister-allow-rules.json" (builtins.toJSON cfg.allowPatterns);
in {
  imports = [inputs.hister.nixosModules.default];

  options.homelab.services.${name} = {
    enable = lib.mkEnableOption "Hister configuration";
    port = lib.mkOption {
      type = lib.types.port;
      description = "Hister bind port";
      default = 4433;
      example = 8080;
    };
    environmentFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      description = "Optional environment file for Hister secrets and settings";
      default = null;
      example = "/var/lib/hister/secrets.env";
    };
    allowPatterns = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "URL regular expressions allowed into Hister's index; an empty list allows all URLs";
      example = ["^https?://github\\.com(/|$)"];
    };
  };

  config = lib.mkIf cfg.enable {
    services.hister = {
      enable = true;
      inherit (cfg) port environmentFile;
      settings.server = {
        address = "127.0.0.1:${toString cfg.port}";
        base_url =
          if homelab.domain != null
          then "https://${name}.${homelab.domain}"
          else "http://localhost:${toString cfg.port}";
      };
    };

    systemd.services.hister.preStart = lib.mkIf (cfg.allowPatterns != []) ''
      rules=/var/lib/hister/rules.json
      umask 077
      if [ -e "$rules" ]; then
        ${pkgs.jq}/bin/jq --slurpfile allow ${allowRules} '.allow = $allow[0]' "$rules" > "$rules.tmp"
      else
        ${pkgs.jq}/bin/jq -n --slurpfile allow ${allowRules} '{allow: $allow[0], skip: [], priority: [], versioning: [], aliases: {}}' > "$rules.tmp"
      fi
      mv "$rules.tmp" "$rules"
    '';
  };
}

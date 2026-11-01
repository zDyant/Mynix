{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) homelab;
  name = "nextcloud";
  cfg = homelab.services.${name};
  fqdn = "${name}.${homelab.domain}";
in {
  options.homelab.services = {
    nextcloud.enable = lib.mkEnableOption "Nextcloud";
  };

  config = lib.mkIf (homelab.enable && cfg.enable) {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud35;
      extraApps = {
        inherit (pkgs.nextcloud35Packages.apps) registration;
      };
      extraAppsEnable = true;
      hostName = fqdn;
      database.createLocally = true;
      config = {
        dbtype = "pgsql";
      };
      settings = {
        trusted_domains = [fqdn];
        overwriteprotocol = "https";
      };
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/nextcloud 0750 nextcloud nextcloud -"
    ];
  };
}

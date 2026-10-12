let
  flake = builtins.getFlake (toString ../.);
  home = flake.nixosConfigurations.gaia.config.home-manager.users.zdyant;
  server = flake.nixosConfigurations.hephaestus.config;
in {
  git = home.xdg.configFile."git/config".source;
  mpv = home.xdg.configFile."mpv/mpv.conf".source;
  resticPrepare = server.services.restic.backups.restic.backupPrepareCommand;
  resticCleanup = server.services.restic.backups.restic.backupCleanupCommand;
  postgresPrepare = server.systemd.services.docker-openmonetis.preStart;
}

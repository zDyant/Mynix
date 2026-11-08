{
  lib,
  pkgs,
  ...
}: {
  imports = lib.fs.scanPaths ./.;

  home.packages = with pkgs; [
    # Apps ---------------------------------------------------------
    rnote # For math
    anki
    filen-cli # https://filen.io
    rclone # For my daily backups
    rbw # bitwarden-cli
    qbittorrent-enhanced # Torrent
    appimage-run
  ];
}

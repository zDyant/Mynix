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
    protonmail-desktop
    rbw # bitwarden-cli
    pear-desktop
    newsflash # RSS Reader
    aria2 # Download Manager
    qbittorrent-enhanced # Torrent
    appimage-run
    brave-origin
  ];
}

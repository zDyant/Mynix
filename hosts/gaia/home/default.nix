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
    rbw # bitwarden-cli
    qbittorrent-enhanced # Torrent
    appimage-run
  ];
}

{
  flakeRoot,
  lib,
  pkgs,
  ...
}: {
  imports = lib.flatten [
    (lib.fs.scanPaths ./.)
    (map (lib.fs.relativeTo flakeRoot) [
      "modules/home/common/floorp"
      "modules/home/common/gaming"
      "modules/home/common/mpv"
      "modules/home/common/nautilus"
      "modules/home/common/nixcord"
      "modules/home/common/yazi"
      "modules/home/common/affinity.nix"
      "modules/home/common/kitty.nix"
      "modules/home/common/npm.nix"
      "modules/home/common/spicetify.nix"
      "modules/home/common/stylix.nix"
      "modules/home/common/tldr.nix"
      "modules/home/common/tmux.nix"
      "modules/home/common/wallpaper-engine.nix"
    ])
  ];

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

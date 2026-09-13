{
  pkgs,
  config,
  lib,
  ...
}: {
  # https://github.com/71zenith/kiseki/blob/6f1c8efbb4ea41bfa32c95d1413f844305b4ad77/home/mpv.nix
  # https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/
  imports = lib.fs.scanPaths ./.;

  home.packages = with pkgs; [
    yt-dlp
  ];
  programs.mpv = {
    enable = true;
    defaultProfiles = ["gpu-hq"];
    scriptOpts = {
      webtorrent.path = "${config.xdg.cacheHome}/mpv";
    };
    scripts = with pkgs.mpvScripts; [
      mpris
      autoload
      memo
      webtorrent-mpv-hook
      thumbfast
      sponsorblock
      autosub
      (quality-menu.override {
        oscSupport = true; # Adds a quality menu to MPV when playing youtube videos
      })
    ];
  };
}

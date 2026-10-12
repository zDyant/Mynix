{
  pkgs,
  config,
  lib,
  ...
}: let
  mpvClipboard = pkgs.writeShellApplication {
    name = "mpv-clipboard";
    runtimeInputs = [
      config.programs.mpv.finalPackage
      pkgs.libnotify
      pkgs.wl-clipboard
    ];
    text = ''
      clipboard="$(wl-paste --no-newline 2>/dev/null || true)"

      if [ -z "$clipboard" ]; then
        notify-send -a mpv "MPV (Clipboard)" "The clipboard does not contain any text."
        exit 1
      fi

      exec mpv -- "$clipboard"
    '';
  };
  mpvClipboardDesktop = pkgs.makeDesktopItem {
    name = "mpv-clipboard";
    desktopName = "MPV (Clipboard)";
    genericName = "Clipboard Media Player";
    comment = "Play the URL or file path from the clipboard";
    exec = "${mpvClipboard}/bin/mpv-clipboard";
    icon = "mpv";
    terminal = false;
    categories = ["AudioVideo" "Player"];
  };
in {
  # https://github.com/71zenith/kiseki/blob/6f1c8efbb4ea41bfa32c95d1413f844305b4ad77/home/mpv.nix
  # https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/
  imports = lib.fs.scanPaths ./home;

  home.packages = [
    pkgs.yt-dlp
    mpvClipboardDesktop
  ];

  programs.mpv = {
    enable = true;
    defaultProfiles = ["high-quality"];
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

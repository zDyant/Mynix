{
  pkgs,
  config,
  lib,
  ...
}:
{
  # https://github.com/71zenith/kiseki/blob/6f1c8efbb4ea41bfa32c95d1413f844305b4ad77/home/mpv.nix
  # https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf/
  imports = [
    ./config.nix
    ./profiles.nix
    ./bindings.nix
  ];
  home.packages = with pkgs; [
    mpvScripts.modernz # INFO: Included here so that the font is installed
    yt-dlp
  ];
  programs.mpv = {
    enable = true;
    defaultProfiles = [ "gpu-hq" ];
    scriptOpts = {
      webtorrent.path = "${config.xdg.cacheHome}/mpv";
      modernz = {
        "download_path" = "${config.xdg.userDirs.videos}/mpv";

        "osc_color" = lib.mkDefault config.lib.stylix.colors.withHashtag.base00;

        "hover_effect_color"   = lib.mkDefault config.lib.stylix.colors.withHashtag.base05;
        "side_buttons_color"   = lib.mkDefault config.lib.stylix.colors.withHashtag.base04;
        "middle_buttons_color" = lib.mkDefault config.lib.stylix.colors.withHashtag.base0D;
        "playpause_color"      = lib.mkDefault config.lib.stylix.colors.withHashtag.base0D;

        "seekbarfg_color"     = lib.mkDefault config.lib.stylix.colors.withHashtag.base0D;
        "seekbarbg_color"     = lib.mkDefault config.lib.stylix.colors.withHashtag.base04;
        "seek_handle_color"   = lib.mkDefault config.lib.stylix.colors.withHashtag.base0D;
        "seekbar_cache_color" = lib.mkDefault config.lib.stylix.colors.withHashtag.base0A;

        "window_controls_color"      = lib.mkDefault config.lib.stylix.colors.withHashtag.base04;
        "windowcontrols_close_hover" = lib.mkDefault config.lib.stylix.colors.withHashtag.base05;
        "windowcontrols_min_hover"   = lib.mkDefault config.lib.stylix.colors.withHashtag.base05;
        "windowcontrols_max_hover"   = lib.mkDefault config.lib.stylix.colors.withHashtag.base05;
      };
    };
    scripts = with pkgs.mpvScripts; [
      mpris
      autoload
      memo
      webtorrent-mpv-hook
      thumbfast
      sponsorblock
      modernz
      autosub
      (quality-menu.override {
        oscSupport = true; # Adds a quality menu to MPV when playing youtube videos
      })
    ];
  };
}

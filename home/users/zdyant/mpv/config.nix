{ config, ... }:
{
  programs.mpv.config = {
    # UI
    osc = "no";
    osd-bar = "no";
    border = "no";

    # Lang
    slang = "en,eng";
    alang = "en,eng";

    # Subs
    sub-auto = "fuzzy";
    sub-fix-timing = "yes";

    # Hardware
    vo = "gpu";
    gpu-api = "vulkan";
    hwdec = "vaapi";
    demuxer-max-bytes = "300MiB";
    demuxer-max-back-bytes = "50MiB";
    demuxer-readahead-secs = "60";

    # Opts
    profile = "high-quality";
    # profile = "gpu-hq";
    keep-open = "yes";
    save-position-on-quit = "yes";
    resume-playback = "yes";
    autofit = "50%";
    force-seekable = "yes";
    autocreate-playlist = "same";
    scale = "ewa_lanczossharp";
    cscale = "ewa_lanczossharp";
    video-sync = "display-resample";
    interpolation = "yes";
    tscale = "oversample";
    image-display-duration = "inf";
    cache = "yes";
    screenshot-directory = "${config.xdg.userDirs.pictures}/mpv";
    ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
  };
}

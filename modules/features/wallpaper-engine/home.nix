{
  lib,
  config,
  ...
}: {
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = lib.mkDefault "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
  };

  # Add env variable for wayland
  systemd.user.services."linux-wallpaperengine" = {
    Service.Environment = [
      "XDG_SESSION_TYPE=wayland"
      "DISPLAY=:0"
      "WAYLAND_DISPLAY=wayland-1"
    ];
  };
}

{ config, ... }:
{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
    wallpapers = [
      {
        monitor = "DP-2";
        wallpaperId = "3549235003";
        #scaling = "fit"; # "stretch" "fit" "fill" "default"
        fps = 60;
      }
    ];
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

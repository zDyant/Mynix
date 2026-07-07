{
  config,
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings.exec-once = [
      (lib.getExe config.programs.floorp.package)
      (lib.getExe config.programs.spicetify.spotifyPackage)
      "${lib.getExe pkgs.easyeffects} --gapplication-service"
    ];
  };
}

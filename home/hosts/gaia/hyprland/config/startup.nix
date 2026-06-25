{
  config,
  lib,
  ...
}: let
  floorp = lib.getExe config.programs.floorp.package;
in {
  wayland.windowManager.hyprland = {
    extraConfig = "
exec-once = spotify  &
exec-once = ${floorp} &
    ";
  };
}

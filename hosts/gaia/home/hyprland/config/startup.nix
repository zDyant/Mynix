{
  config,
  lib,
  ...
}: let
  inherit
    (import ./_helper.nix {inherit lib;})
    on_startup
    ;
in {
  wayland.windowManager.hyprland.settings.on = on_startup [
    (lib.getExe config.programs.floorp.package)
    (lib.getExe config.programs.spicetify.spotifyPackage)
  ];
}

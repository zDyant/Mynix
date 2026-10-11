{lib, ...}: let
  inherit
    (import ./_helper.nix {inherit lib;})
    mkCurves
    mkAnimations
    ;
in {
  wayland.windowManager.hyprland.settings = {
    curve = mkCurves {
      bezier = {
        md3_decel = "0.05, 0.7, 0.1, 1";
        md3_accel = "0.3, 0, 0.8, 0.15";
        menu_decel = "0.1, 1, 0, 1";
        menu_accel = "0.38, 0.04, 1, 0.07";
      };
      spring = {
        spring_menu = "1, 240, 24";
        spring_window = "1, 240, 24";
        spring_open = "1, 240, 24";
        spring_workspace = "1, 240, 24";
        spring_special = "1, 240, 24";
      };
    };

    # "<leaf>, <speed>, <kind>:<curve>[, <style>]", "<leaf>, off" to disable.
    # Order matters: a parent leaf resets its children.
    animation = mkAnimations [
      "windows, 1, spring:spring_window"
      "windowsIn, 1, spring:spring_window, popin 40%"
      "windowsOut, 1, spring:spring_window, popin 40%"
      "border, off"
      "borderangle, off"
      "fade, off"
      "zoomFactor, 6, bezier:md3_decel"
      "layersIn, 3, spring:spring_menu, slide"
      "layersOut, 1.6, bezier:menu_accel, slide"
      "fadeLayersIn, 2, bezier:menu_decel"
      "fadeLayersOut, 1.6, bezier:menu_accel"
      "workspaces, 1, spring:spring_workspace, slidevert"
      "specialWorkspace, 1, spring:spring_special, slidefadevert 40%"
    ];
  };
}

{...}: {
  wayland.windowManager.hyprland.settings.animations = {
    enabled = true;
    bezier = [
      "emphasizedAccel, 0.3, 0, 0.8, 0.15"
      "emphasizedDecel, 0.05, 0.7, 0.1, 1"
      "standard, 0.2, 0, 0, 1"
      "swipe, 0.6, 0.0, 0.2, 1.05"
    ];

    animation = [
      "layersIn,         1, 5, emphasizedDecel, slide"
      "layersOut,        1, 4, emphasizedAccel, slide"
      "fadeLayers,       1, 4, standard"

      "windowsIn,        1, 5, emphasizedDecel, gnomed"
      "windowsOut,       1, 5, emphasizedAccel, gnomed"
      "windowsMove,      1, 5, standard"

      "workspaces,       1, 4, swipe, slidefade 20%"
      "specialWorkspace, 1, 4, swipe, slidefadevert 20%"

      "fade,             1, 6, emphasizedDecel"
      "fadeDim,          1, 6, standard"
      "border,           1, 6, standard"
    ];
  };
}

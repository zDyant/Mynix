{lib, ...}: {
  wayland.windowManager.hyprland.settings.animations = {
    enabled = true;
    bezier = [
      "emphasizedAccel, 0.3, 0, 0.8, 0.15"
      "emphasizedDecel, 0.05, 0.7, 0.1, 1"
      "standard, 0.2, 0, 0, 1"
      "swipe, 0.4, 0, 0.2, 1"
    ];

    animation = lib.mkForce [
      "layersIn,         1, 5, emphasizedDecel, popin"
      "layersOut,        1, 4, emphasizedAccel, popin"

      "windowsIn,        1, 5, emphasizedDecel, slide"
      "windowsOut,       1, 4, emphasizedAccel, gnomed"
      "windowsMove,      1, 5, standard"

      "workspaces,       1, 5, swipe, slidevert"

      "fade,             1, 5, swipe"
      "fadeOut,          1, 4, emphasizedAccel"
    ];
  };
}

{...}: {
  wayland.windowManager.hyprland = {
    extraConfig = ''

       animations {
        enabled = yes

        bezier = emphasizedAccel, 0.3, 0, 0.8, 0.15
        bezier = emphasizedDecel, 0.05, 0.7, 0.1, 1
        bezier = standard, 0.2, 0, 0, 1
        bezier = swipe, 0.6, 0.0, 0.2, 1.05

        animation = layersIn, 1, 5, emphasizedDecel, slide
        animation = layersOut, 1, 4, emphasizedAccel, slide
        animation = fadeLayers, 1, 4, standard

        animation = windowsIn, 1, 5, emphasizedDecel
        animation = windowsOut, 1, 3, emphasizedAccel
        animation = windowsMove, 1, 4, standard

        animation = workspaces, 1, 4, swipe, slidefade 20%
        animation = specialWorkspace, 1, 4, swipe, slidefadevert 20%

        animation = fade, 1, 6, standard
        animation = fadeDim, 1, 6, standard
        animation = border, 1, 6, standard
      }
    '';
  };
}

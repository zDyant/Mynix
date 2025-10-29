{...}: {
  wayland.windowManager.hyprland = {
    extraConfig = ''

       animations {
        enabled = yes

        bezier = swipe, 0.6, 0.0, 0.2, 1.05
        bezier = easeOutQuint,0.23,1,0.32,1
        bezier = easeInOutCubic,0.65,0.05,0.36,1
        bezier = linear,0,0,1,1
        bezier = quick,0.15,0,0.1,1

        animation = windows,    1, 6, easeOutQuint
        animation = windowsIn,  1, 6, easeOutQuint, popin 80%
        animation = windowsOut, 1, 4, linear,       popin
        animation = windowsMove,1, 4, easeInOutCubic

        animation = fade,       1, 6, easeInOutCubic
        animation = fadeIn,     1, 6, easeInOutCubic
        animation = fadeOut,    1, 6, quick

        animation = layers,     1, 6, easeOutQuint
        animation = layersIn,   1, 6, easeOutQuint, fade
        animation = layersOut,  1, 4, linear, popin

        animation = workspaces,  1, 6, swipe, slide
      }

    '';
  };
}

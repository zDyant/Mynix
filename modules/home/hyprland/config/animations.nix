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

        animation = windows,    1, 4, easeOutQuint
        animation = windowsIn,  1, 4, easeOutQuint, popin 60%
        animation = windowsOut, 1, 3, linear,       popin 80%
        animation = windowsMove,1, 3, easeInOutCubic

        animation = fade,       1, 4, easeInOutCubic
        animation = fadeIn,     1, 4, easeInOutCubic
        animation = fadeOut,    1, 3, quick

        animation = layers,     1, 4, easeOutQuint
        animation = layersIn,   1, 4, easeOutQuint, fade
        animation = layersOut,  1, 3, easeInOutCubic, popin

        animation = workspaces, 1, 4, swipe, slidefade 20%
      }

    '';
  };
}

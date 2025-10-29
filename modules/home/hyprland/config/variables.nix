{ ... }: {
  wayland.windowManager.hyprland.settings.env = [
    "NIXOS_OZONE_WL, 1"
    "NIXPKGS_ALLOW_UNFREE, 1"
    "CLUTTER_BACKEND,wayland"
    "GDK_BACKEND,wayland,x11"
    "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    "QT_QPA_PLATFORM,wayland;xcb"
    "QT_SCALE_FACTOR,1"
    "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
    "XDG_CURRENT_DESKTOP,Hyprland"
    "XDG_SESSION_DESKTOP,Hyprland"
    "XDG_SESSION_TYPE,wayland"

    # "WLR_RENDERER,vulkan"  # WARN: KEEP IT OFF, OTHERWISE HYPRLAND WON'T LAUNCH

    # firefox
    "MOZ_ENABLE_WAYLAND,1"
    # This is to make electron apps start in wayland
    "ELECTRON_OZONE_PLATFORM_HINT,wayland"

  ];
}

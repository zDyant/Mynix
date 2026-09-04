{lib, ...}: let
  inherit (import ./_helper.nix {inherit lib;}) mkEnv;
in {
  wayland.windowManager.hyprland.settings.env = mkEnv {
    NIXOS_OZONE_WL = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    GTK_USE_PORTAL = "1";
    MOZ_ENABLE_WAYLAND = "1"; # firefox
    ELECTRON_OZONE_PLATFORM_HINT = "1"; # electron apps on wayland
    XFT_DPI = "144";
    GDK_SCALE = "1.5";
  };
}

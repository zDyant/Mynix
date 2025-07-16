{ ... }:
{
wayland.windowManager.hyprland = {
  extraConfig = "

$wallDIR=$HOME/Pictures/wallpapers

# wallpaper stuff / More wallpaper options below
exec-once = swww query || swww init

# Startup
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment PATH
exec-once = systemctl --user restart xdg-desktop-portal.service

# startup apps
exec-once = nm-applet --indicator &
exec-once = hypridle &
exec-once = QT_STYLE_OVERRIDE= && QT_QPA_PLATFORMTHEME= && QT_QUICK_CONTROLS_STYLE=Fusion && qs &
exec-once = app.zen_browser.zen
exec-once = obsidian
exec-once = spotify

#clipboard manager
exec-once = wl-paste --type text --watch cliphist store 
exec-once = wl-paste --type image --watch cliphist store

    ";
  };
}

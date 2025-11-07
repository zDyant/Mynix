{ ... }:
{
wayland.windowManager.hyprland = {
  extraConfig = "

$wallDIR=$HOME/Pictures/wallpapers

# Startup
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment PATH
exec-once = systemctl --user restart xdg-desktop-portal.service

# startup apps
exec-once = nm-applet --indicator &
exec-once = hypridle &
exec-once = spotify
    ";
  };
}

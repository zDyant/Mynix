{...}: {
  wayland.windowManager.hyprland = {
    extraConfig = "

$wallDIR=$HOME/Pictures/wallpapers


# startup apps
exec-once = hypridle &
exec-once = spotify
    ";
  };
}

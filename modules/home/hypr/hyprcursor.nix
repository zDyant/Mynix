{ pkgs, ... }:
let
  cursor = {
    name = "rose-pine-hyprcursor";
    size = 28;
  };
in
{

  home.packages = with pkgs; [
    hyprcursor
    rose-pine-hyprcursor
  ];

  wayland.windowManager.hyprland.settings = {
    env = [
      "HYPRCURSOR_THEME,${cursor.name}"
      "HYPRCURSOR_SIZE,${toString cursor.size}"
    ];

    exec-once = [
      "hyprctl setcursor ${cursor.name} ${toString cursor.size}"
    ];
  };
}

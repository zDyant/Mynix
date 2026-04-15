{ lib, pkgs, ... }:
let
  dotsPath = "$HOME/Documents/dots/";
  terminal = lib.getExe pkgs.kitty;
  shell = "${lib.getExe pkgs.zsh} -c";
  playerctl = "${lib.getExe pkgs.playerctl} -p spotify";
in {
  wayland.windowManager.hyprland.settings.bind = [
    "$mod SHIFT, S, exec, ${
      lib.getExe pkgs.hyprshot
    } -m region --clipboard-only"

    # Sound control
    "$mod, V, exec, volume-control --inc" # volume up
    "$mod, Z, exec, volume-control --dec" # volume down
    "$mod, SPACE, exec, ${playerctl} play-pause"
    "$mod, C, exec,     ${playerctl} next"
    "$mod, X, exec,     ${playerctl} previous"

    # Launchers
    "$mod, T, exec, ${terminal}" # Launch terminal
    "$mod, E, exec, ${terminal} ${shell} yazi" # File manager
    "$mod, return, exec, ${terminal} -d ${dotsPath} ${shell} nvim -c 'terminal'"

    "$mod, S, exec, ${lib.getExe pkgs.grim} - | ${lib.getExe' pkgs.wl-clipboard "wl-copy"}"
  ];
}

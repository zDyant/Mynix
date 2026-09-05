{lib, ...}: let
  inherit
    (import ../_helper.nix {inherit lib;})
    bind
    exec
    focus
    mv
    resize
    ;
  workspaces = [1 2 3 4 5 6];
in {
  imports = lib.fs.scanPaths ./.;

  wayland.windowManager.hyprland.settings.bind =
    [
      # Windows control ------------------------------------------------------------
      (bind "SUPER + SHIFT + Q" (exec "hyprctl kill"))
      (bind "SUPER + Q" "hl.dsp.window.close()")
      (bind "SUPER + F" "hl.dsp.window.fullscreen({mode='fullscreen'})")
      (bind "SUPER + SHIFT + F" "hl.dsp.window.float({action='toggle'})")


      (bind "SUPER + h" (focus "left"))
      (bind "SUPER + l" (focus "right"))
      (bind "SUPER + k" (focus "up"))
      (bind "SUPER + j" (focus "down"))

      (bind "SUPER + CTRL + h" (mv "left"))
      (bind "SUPER + CTRL + l" (mv "right"))
      (bind "SUPER + CTRL + k" (mv "up"))
      (bind "SUPER + CTRL + j" (mv "down"))

      (resize "h" (-24) 0)
      (resize "l" 24 0)
      (resize "k" 0 (-24))
      (resize "j" 0 24)

      # Groups
      (bind "SUPER +  G" "hl.dsp.group.toggle()")
      (bind "ALT + tab " "hl.dsp.group.next()")

      # Hyprland ---------------------------------------------------------
      (bind "CTRL + ALT + Delete" "hl.dsp.exit()")
    ]
    # Move active window to a workspace silently
    ++ (map (i: bind "SUPER + CTRL + ${toString i}" (mv i)) workspaces)
    # Switch workspaces with mod + 0,1,2...
    ++ (map (i: bind "SUPER + ${toString i}" (focus i)) workspaces);



}

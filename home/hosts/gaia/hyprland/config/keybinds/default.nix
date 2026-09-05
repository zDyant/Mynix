{lib, ...}: let
  inherit
    (import ../_helper.nix {inherit lib;})
    bind
    exec
    focus
    mv
    ;
in {
  imports = lib.fs.scanPaths ./.;
  wayland.windowManager.hyprland.settings.bind = [
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

    (bind "SUPER + SHIFT + h" "hl.dsp.window.resize({ x = -24, y = 0, relative = true })" {repeating = true;})
    (bind "SUPER + SHIFT + l" "hl.dsp.window.resize({ x = 24, y = 0, relative = true })" {repeating = true;})
    (bind "SUPER + SHIFT + k" "hl.dsp.window.resize({ x = 0, y = -24, relative = true })" {repeating = true;})
    (bind "SUPER + SHIFT + j" "hl.dsp.window.resize({ x = 0, y = 24, relative = true })" {repeating = true;})

    # Groups
    (bind "SUPER +  G" "hl.dsp.group.toggle()")
    (bind "ALT + tab " "hl.dsp.group.next()")

    # Hyprland ---------------------------------------------------------
    (bind "CTRL + ALT + Delete" "hl.dsp.exit()")

    # Workspaces -------------------------------------------------------

    # Move active window to a workspace silently
    (bind "SUPER + CTRL + 1" (mv 1))
    (bind "SUPER + CTRL + 1" (mv 1))
    (bind "SUPER + CTRL + 2" (mv 2))
    (bind "SUPER + CTRL + 3" (mv 3))
    (bind "SUPER + CTRL + 4" (mv 4))
    (bind "SUPER + CTRL + 5" (mv 5))
    (bind "SUPER + CTRL + 6" (mv 6))

    # Switch workspaces with mod + [0-9]
    (bind "SUPER + 1" (focus 1))
    (bind "SUPER + 2" (focus 2))
    (bind "SUPER + 3" (focus 3))
    (bind "SUPER + 4" (focus 4))
    (bind "SUPER + 5" (focus 5))
    (bind "SUPER + 6" (focus 6))
  ];
}

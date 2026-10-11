{lib, ...}: let
  inherit
    (import ../_helper.nix {inherit lib;})
    bind
    exec
    focus
    mv
    mvxy
    func
    ;
  workspaces = [1 2 3 4 5 6];
in {
  imports = lib.fs.scanPaths ./.;

  wayland.windowManager.hyprland.settings.bind = let
    resize = mvxy "resize";
    moveFloat = mvxy "move";
  in
    [
      # Windows control ------------------------------------------------------------
      (bind "SUPER + SHIFT + Q" (exec "hyprctl kill"))
      (bind "SUPER + Q" "hl.dsp.window.close()")
      (bind "SUPER + F" "hl.dsp.window.fullscreen({mode='fullscreen'})")
      (bind "SUPER + SHIFT + F" "hl.dsp.window.float({action='toggle'})")
      (bind "SUPER + P" "hl.dsp.window.pin({ action = 'toggle' })")

      (bind "SUPER + semicolon" (func "hl.dispatch(hl.dsp.window.cycle_next({ floating = not hl.get_active_window().floating }))"))
      (bind "SUPER + h" (focus "left"))
      (bind "SUPER + l" (focus "right"))
      (bind "SUPER + k" (focus "up"))
      (bind "SUPER + j" (focus "down"))

      (bind "SUPER + CTRL + h" (mv "left"))
      (bind "SUPER + CTRL + l" (mv "right"))
      (bind "SUPER + CTRL + k" (mv "up"))
      (bind "SUPER + CTRL + j" (mv "down"))

      (bind "SUPER + SHIFT + h" (resize (-32) 0) {repeating = true;})
      (bind "SUPER + SHIFT + l" (resize 32 0) {repeating = true;})
      (bind "SUPER + SHIFT + k" (resize 0 (-32)) {repeating = true;})
      (bind "SUPER + SHIFT + j" (resize 0 32) {repeating = true;})

      (bind "SUPER + ALT + h" (moveFloat (-64) 0) {repeating = true;})
      (bind "SUPER + ALT + l" (moveFloat 64 0) {repeating = true;})
      (bind "SUPER + ALT + k" (moveFloat 0 (-64)) {repeating = true;})
      (bind "SUPER + ALT + j" (moveFloat 0 64) {repeating = true;})

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

{ lib, pkgs, ... }: {

  wayland.windowManager.hyprland.settings."$mod" = "SUPER";
  wayland.windowManager.hyprland.settings = {
    # Windows control ------------------------------------------------------------
    bind = [
      "$mod, Q, killactive,"
      "$mod, F, fullscreen"
      "$mod SHIFT, F, togglefloating"

      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"

      "$mod CTRL, h, movewindow, l"
      "$mod CTRL, l, movewindow, r"
      "$mod CTRL, k, movewindow, u"
      "$mod CTRL, j, movewindow, d"

      # Groups
      "$mod, G, togglegroup"
      "ALT, tab, changegroupactive" # change focus to another window

      # Special workspace
      "$mod SHIFT, U, movetoworkspace, special"
      "$mod, U, togglespecialworkspace"

      # Sound control
      "$mod, V, exec, volume-control --inc" # volume up
      "$mod, Z, exec, volume-control --dec" # volume down
      "$mod, SPACE, exec, media-control --pause"
      "$mod, C, exec, media-control --nxt"
      "$mod, X, exec, media-control --prv"

      "$mod SHIFT, S, exec, ${lib.getExe pkgs.hyprshot} -m region --clipboard-only"
      "$mod, S, exec, ${lib.getExe pkgs.hyprshot} -m region"

      # Launchers
      "$mod, T, exec, kitty" # Launch terminal
      "$mod, E, exec, kitty zsh -c yazi" # File manager

      # Hyprland ---------------------------------------------------------
      "CTRL ALT, Delete, exec, hyprctl dispatch exit 0"

      # ------------------------------------------------------------------
      # Move using tab
      "$mod, tab, workspace, m+1"
      "$mod SHIFT, tab, workspace, m-1"

      # Scroll through existing workspaces with mod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      "$mod, period, workspace, e+1"
      "$mod, comma, workspace, e-1"

      # Move active window and follow to workspace mod + SHIFT [0-9]
      "$mod SHIFT, code:10, movetoworkspace, 1"
      "$mod SHIFT, code:11, movetoworkspace, 2"
      "$mod SHIFT, code:12, movetoworkspace, 3"
      "$mod SHIFT, code:13, movetoworkspace, 4"
      "$mod SHIFT, code:14, movetoworkspace, 5"
      "$mod SHIFT, code:15, movetoworkspace, 6"
      "$mod SHIFT, code:16, movetoworkspace, 7"
      "$mod SHIFT, code:17, movetoworkspace, 8"
      "$mod SHIFT, code:18, movetoworkspace, 9"
      "$mod SHIFT, code:19, movetoworkspace, 10"

      # Move active window to a workspace silently mod + CTRL [0-9]
      "$mod CTRL, code:10, movetoworkspacesilent, 1"
      "$mod CTRL, code:11, movetoworkspacesilent, 2"
      "$mod CTRL, code:12, movetoworkspacesilent, 3"
      "$mod CTRL, code:13, movetoworkspacesilent, 4"
      "$mod CTRL, code:14, movetoworkspacesilent, 5"
      "$mod CTRL, code:15, movetoworkspacesilent, 6"
      "$mod CTRL, code:16, movetoworkspacesilent, 7"
      "$mod CTRL, code:17, movetoworkspacesilent, 8"
      "$mod CTRL, code:18, movetoworkspacesilent, 9"
      "$mod CTRL, code:19, movetoworkspacesilent, 10"

      # Workspaces ------------------------------------------------------------------
      # The following mappings use the key codes to better support various keyboard layouts
      # 1 is code:10, 2 is code 11, etc

      # Switch workspaces with mod + [0-9] 
      "$mod, code:10, workspace, 1"
      "$mod, code:11, workspace, 2"
      "$mod, code:12, workspace, 3"
      "$mod, code:13, workspace, 4"
      "$mod, code:14, workspace, 5"
      "$mod, code:15, workspace, 6"
      "$mod, code:16, workspace, 7"
      "$mod, code:17, workspace, 8"
      "$mod, code:18, workspace, 9"
      "$mod, code:19, workspace, 10"
    ];

    # Resize
    binde = [
      "$mod SHIFT, left, resizeactive,-50 0"
      "$mod SHIFT, right, resizeactive,50 0"
      "$mod SHIFT, up, resizeactive,0 -50"
      "$mod SHIFT, down, resizeactive,0 50"
    ];

    # Move/resize windows with mod + LMB/RMB and dragging
    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
  };
}

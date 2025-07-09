{ ... }:
{

  wayland.windowManager.hyprland = {
    extraConfig = ''
$mainMod = SUPER
$configs = ../configs/
$files = yazi
$term = kitty

# Windows control ------------------------------------------------------------

# Commands
bind = $mainMod, Q, killactive,
bind = $mainMod, F, fullscreen
bind = $mainMod SHIFT, F, togglefloating, # Actual window float
bind = $mainMod ALT, F, exec, hyprctl dispatch workspaceopt allfloat # All windows float

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Resize
binde = $mainMod SHIFT, left, resizeactive,-50 0
binde = $mainMod SHIFT, right, resizeactive,50 0
binde = $mainMod SHIFT, up, resizeactive,0 -50
binde = $mainMod SHIFT, down, resizeactive,0 50

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Move
bind = $mainMod CTRL, left, movewindow, l
bind = $mainMod CTRL, right, movewindow, r
bind = $mainMod CTRL, up, movewindow, u
bind = $mainMod CTRL, down, movewindow, d

# Master Layout
bind = $mainMod CTRL, D, layoutmsg, removemaster
bind = $mainMod, I, layoutmsg, addmaster
bind = $mainMod, J, layoutmsg, cyclenext
bind = $mainMod, K, layoutmsg, cycleprev
bind = $mainMod, M, exec, hyprctl dispatch splitratio 0.3

# Groups
bind = $mainMod, G, togglegroup
bind = ALT, tab, changegroupactive  #change focus to another window  

# Move active window and follow to workspace mainMod + SHIFT [0-9]
bind = $mainMod SHIFT, code:10, movetoworkspace, 1
bind = $mainMod SHIFT, code:11, movetoworkspace, 2
bind = $mainMod SHIFT, code:12, movetoworkspace, 3
bind = $mainMod SHIFT, code:13, movetoworkspace, 4
bind = $mainMod SHIFT, code:14, movetoworkspace, 5
bind = $mainMod SHIFT, code:15, movetoworkspace, 6
bind = $mainMod SHIFT, code:16, movetoworkspace, 7
bind = $mainMod SHIFT, code:17, movetoworkspace, 8
bind = $mainMod SHIFT, code:18, movetoworkspace, 9
bind = $mainMod SHIFT, code:19, movetoworkspace, 10
bind = $mainMod SHIFT, bracketleft, movetoworkspace, -1 # brackets [ or ]
bind = $mainMod SHIFT, bracketright, movetoworkspace, +1

# Move active window to a workspace silently mainMod + CTRL [0-9]
bind = $mainMod CTRL, code:10, movetoworkspacesilent, 1
bind = $mainMod CTRL, code:11, movetoworkspacesilent, 2
bind = $mainMod CTRL, code:12, movetoworkspacesilent, 3
bind = $mainMod CTRL, code:13, movetoworkspacesilent, 4
bind = $mainMod CTRL, code:14, movetoworkspacesilent, 5
bind = $mainMod CTRL, code:15, movetoworkspacesilent, 6
bind = $mainMod CTRL, code:16, movetoworkspacesilent, 7
bind = $mainMod CTRL, code:17, movetoworkspacesilent, 8
bind = $mainMod CTRL, code:18, movetoworkspacesilent, 9
bind = $mainMod CTRL, code:19, movetoworkspacesilent, 10
bind = $mainMod CTRL, bracketleft, movetoworkspacesilent, -1 # brackets [ or ]
bind = $mainMod CTRL, bracketright, movetoworkspacesilent, +1

# Workspaces ------------------------------------------------------------------

# The following mappings use the key codes to better support various keyboard layouts
# 1 is code:10, 2 is code 11, etc

# Switch workspaces with mainMod + [0-9] 
bind = $mainMod, code:10, workspace, 1
bind = $mainMod, code:11, workspace, 2
bind = $mainMod, code:12, workspace, 3
bind = $mainMod, code:13, workspace, 4
bind = $mainMod, code:14, workspace, 5
bind = $mainMod, code:15, workspace, 6
bind = $mainMod, code:16, workspace, 7
bind = $mainMod, code:17, workspace, 8
bind = $mainMod, code:18, workspace, 9
bind = $mainMod, code:19, workspace, 10

# Move using tab
bind = $mainMod, tab, workspace, m+1
bind = $mainMod SHIFT, tab, workspace, m-1

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1
bind = $mainMod, period, workspace, e+1
bind = $mainMod, comma, workspace, e-1

# Special workspace
bind = $mainMod SHIFT, U, movetoworkspace, special
bind = $mainMod, U, togglespecialworkspace,

# Scripts ------------------------------------------------------------------------

# Sound control
bind = $mainMod, V, exec, volume-control --inc #volume up
bind = $mainMod, Z, exec, volume-control --dec #volume down

bind = $mainMod, SPACE, exec, media-control --pause
bind = $mainMod, C, exec, media-control --nxt
bind = $mainMod, X, exec, media-control --prv

# Wallpapers
bind = $mainMod, W, exec, wallpaper-select && set-pywal no-tty && refresh # Select wallpaper to apply
# bind = CTRL ALT, W, exec, wallpaper-random # Random wallpapers

bind = $mainMod, Print, exec, take-screenshot --now

# screenshot with swappy (another screenshot tool)
bind = $mainMod SHIFT, S, exec, take-screenshot --swappy

# Launchers
bindr = $mainMod, $mainMod_L, exec, pkill rofi || rofi -show # drun -modi drun,filebrowser,run,window  Rofi
bind = $mainMod, T, exec, $term  # Launch terminal
bind = $mainMod, E, exec, $files # File manager

bind = $mainMod ALT, V, exec, clip-manager # Clipboard Manager

# Misc
bind = $mainMod ALT, L, exec, change-layout # Toggle Master or Dwindle Layout

# For passthrough keyboard into a VM
# bind = $mainMod ALT, P, submap, passthru
# submap = passthru

# to unbind
#bind = $mainMod ALT, P, submap, reset
#submap = reset

# Hyprland ---------------------------------------------------------
bind = CTRL ALT, Delete, exec, hyprctl dispatch exit 0
    '';
 };
}

{ ... }:
{

  wayland.windowManager.hyprland = {
    extraConfig = "
windowrulev2 = idleinhibit fullscreen, fullscreen:1

# Windowrule ----------------------------------------------------------------------
  windowrule = tag +browser, class:^(zen-alpha|zen)$
  windowrule = tag +browser, class:^(obsidian)$
  
  # gamestore tags -------------------------------------------
  windowrule = tag +gamestore, class:^([Ss]team)$
  windowrule = tag +gamestore, title:^([Ll]utris)$
  windowrule = tag +gamestore, class:^(com.heroicgameslauncher.hgl)$
  
  # game tags ------------------------------------------------
  windowrule = tag +games, class:^(gamescope)$
  windowrule = tag +games, class:^(steam_app_\d+)$
  
  # IM Tags --------------------------------------------------
  windowrule = tag +im, class:^([Ff]erdium)$
  windowrule = tag +im, class:^(.*[Cc]ord) 
  windowrule = tag +im, class:^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$
  
  # viewer tags
  windowrule = tag +viewer, class:^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$ # system monitor
  windowrule = tag +viewer, class:^(evince)$ # document viewer 
  windowrule = tag +viewer, class:^(eog|org.gnome.Loupe)$ # image viewer

  # music tags -------------------------------------
  windowrule = tag +music, class:^([Ss]potify)$
  
  # Move to workspaces -----------------------------------------
  # windowrule move to workspace
  windowrule = workspace 1, tag:browser*
  windowrule = workspace 2 silent, tag:gamestore*
  windowrule = workspace 2 silent, tag:games*
  windowrule = workspace 3 silent, tag:im*
  windowrule = workspace 5 silent, tag:music*
  
  # Float popups and dialogue  ---------------------------------
  windowrule = float, title:^(Authentication Required)$
  windowrule = center, title:^(Authentication Required)$
  windowrule = float, class:(codium|codium-url-handler|VSCodium), title:negative:(.*codium.*|.*VSCodium.*)
  windowrule = float, class:^(com.heroicgameslauncher.hgl)$, title:negative:(Heroic Games Launcher)
  windowrule = float, class:^([Ss]team)$, title:negative:^([Ss]team)$
  windowrule = float, class:([Tt]hunar), title:negative:(.*[Tt]hunar.*)
  
  # Blur and Fullscreen ----------------------------------------
  windowrule = noblur, tag:games*
  windowrule = fullscreen, tag:games*
  
  # Extras -----------------------------------------------------
  windowrule = keepaspectratio, title:^(Picture-in-Picture)$

  # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
  # Smart gaps / No gaps when only
  workspace = w[tv1], gapsout:0, gapsin:0
  workspace = f[1], gapsout:0, gapsin:0
  windowrule = bordersize 4, floating:0, onworkspace:w[tv1]
  windowrule = rounding 0, floating:0, onworkspace:w[tv1]
  windowrule = bordersize 4, floating:0, onworkspace:f[1]
  windowrule = rounding 0, floating:0, onworkspace:f[1]

  # Layerrule ----------------------------------------------------------------------------------------
  # Blur --------------------------------------------------------
  
  # Opacity -----------------------------------------------------
  # First value: focused, second:not focused
  
  windowrulev2 = opacity 1, 1, title:^(Picture-in-Picture)$
  
  # Animations --------------------------------------------------
  layerrule = animation slide right, notificationsmenu
  layerrule = animation slide left, dashboardmenu
  
  # Picture-in-a-Picture ----------------------------------------
  # (PIP) rules: Oddly, some need re-duplication.  This is because the window for
  # PIP changes after on first launch, and will not inherant the rules...
  
  # windowrulev2=opacity 0.95 0.75,title:^(Picture-in-Picture)$ # for opacity: [focus num] [bg num]
  # Interestingly, the opacity rule above doesn't need the reduplication?
  windowrulev2=pin,title:^(Picture-in-Picture)$ 
  windowrulev2=float, title:^(Picture-in-Picture)$
  windowrulev2=size 25% 25%,title:^(Picture-in-Picture)$ 
  windowrulev2=move 72% 7%,title:^(Picture-in-Picture)$ 
  
  windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
  windowrulev2 = noanim,class:^(xwaylandvideobridge)$
  windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
  windowrulev2 = maxsize 1 1,class:^(xwaylandvideobridge)$
  windowrulev2 = noblur,class:^(xwaylandvideobridge)$
    ";
  };
}

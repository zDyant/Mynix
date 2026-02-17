{ ... }: {

  wayland.windowManager.hyprland = {
    extraConfig =
      "
      windowrulev2 = idleinhibit fullscreen, fullscreen:1

      
      windowrule = tag +browser, class:^([Ff]loorp)$
      windowrule = tag +im,      class:^([Ff]erdium)$
      windowrule = tag +im,      class:^(.*[Cc]ord) 
      windowrule = tag +music,   class:^([Ss]potify)$

      # Move to workspaces -----------------------------------------
      # windowrule move to workspace
      windowrule = workspace 1, tag:browser*
      windowrule = workspace 3 silent, tag:im*
      windowrule = workspace 5 silent, tag:music*
      
      # Float popups and dialogue  ---------------------------------
      windowrule   = keepaspectratio, title:^(Picture.in.Picture|Picture-in-Picture)$
      windowrulev2 = pin,             title:^(Picture.in.Picture|Picture-in-Picture)$
      windowrulev2 = float,           title:^(Picture.in.Picture|Picture-in-Picture)$
      windowrulev2 = size 25% 25%,    title:^(Picture.in.Picture|Picture-in-Picture)$
      windowrulev2 = move 72% 7%,     title:^(Picture.in.Picture|Picture-in-Picture)$
      
      windowrule = float,  title:^(Authentication Required)$
      windowrule = center, title:^(Authentication Required)$

      windowrule = float, title:^(Open|Save|File|Folder).*$
      windowrule = float, title:^(Open File|Save File|Save As).*$
      windowrule = float, title:^(xdg-desktop-portal.*).*$
      windowrule = float, class:^(pavucontrol)$

      # Browser extensions - floating popup style
      windowrule   = float,        title:^(Extension:.*)$
      windowrulev2 = size 20% 40%, title:^(Extension:.*)$
      
      # Extras -----------------------------------------------------
      
      # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
      # Smart gaps / No gaps when only
      workspace  = w[tv1],        gapsout:0,  gapsin:0
      workspace  = f[1],          gapsout:0,  gapsin:0
      windowrule = bordersize 1, floating:0, onworkspace:w[tv1]
      windowrule = rounding 0,   floating:0, onworkspace:w[tv1]
      windowrule = bordersize 1, floating:0, onworkspace:f[1]
      windowrule = rounding 0,   floating:0, onworkspace:f[1]

      windowrule = size 65% 100%, class:^(floorp)$

      # Layerrule ----------------------------------------------------------------------------------------
      # WARN: Remove border around hyprshot screenshots
      layerrule = noanim, selection

      windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
      windowrulev2 = noanim,                           class:^(xwaylandvideobridge)$
      windowrulev2 = noinitialfocus,                   class:^(xwaylandvideobridge)$
      windowrulev2 = maxsize 1 1,                      class:^(xwaylandvideobridge)$
      windowrulev2 = noblur,                           class:^(xwaylandvideobridge)$
      ";
  };
}

{ ... }:
{

wayland.windowManager.hyprland = {
  extraConfig = "

windowrulev2 = idleinhibit fullscreen, fullscreen:1

windowrule = float, pavucontrol
windowrule = float, eog # Eye of gnome

#opacity (transparent) #enable as desired
#first value: focused, second:not focused
windowrulev2 = opacity 1, 1, title:^(Picture-in-Picture)$

# Picture-in-a-Picture (PIP) rules: Oddly, some need re-duplication.  This is because the window for
# PIP changes after on first launch, and will not inherant the rules...
windowrulev2=opacity 0.95 0.75,title:^(Picture-in-Picture)$ # for opacity: [focus num] [bg num]
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

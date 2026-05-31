{...}: {
  wayland.windowManager.hyprland.settings = {
    layerrule = [
      # INFO: Remove border around hyprshot screenshots
      "no_anim on, match:namespace selection"
    ];

    windowrule = [
      # # Idle & Fullscreen
      "idle_inhibit fullscreen, match:fullscreen true"
      "idle_inhibit fullscreen, match:fullscreen 1"

      "tag +browser, match:class ^([Ff]loorp)$"
      "tag +im,      match:class ^(.*[Cc]ord)$"
      "tag +music,   match:class ^([Ss]potify)$"
      "tag +config,  match:class ^(pavucontrol)$"
      "tag +config,  match:class ^(Open|Save|File|Folder)$"
      "tag +config,  match:class ^(Open File|Save File|Save as)$"
      "tag +config,  match:class ^(Authentication Required)$"

      # Move to workspaces -----------------------------------------
      "workspace 1,        match:tag browser*"
      "workspace 3 silent, match:tag im*"
      "workspace 5 silent, match:tag music*"
      "float on,           match:tag config*"
      "center on,          match:tag config*"

      "float on,     match:class ^(download-manager)$"
      "size 40% 60%, match:class ^(download-manager)$"

      "match:title ^(Picture-in-Picture)$, float on, move 72% 7%, pin on keep_aspect_ratio on, size 40%"
    ];
  };
}

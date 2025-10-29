{ config, lib, ... }: {
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";

    dwindle = {
      pseudotile = "yes";
      preserve_split = "yes";
      special_scale_factor = 0.8;
    };

    master = {
      new_on_top = 1;
      mfact = 0.5;
    };

    general = {
      gaps_in = 4;
      gaps_out = 10;
      border_size = 4;
      resize_on_border = false;
      "col.active_border" = lib.mkForce "rgb(${config.lib.stylix.colors.base0A})";
      layout = "dwindle";
    };

    decoration = {
      rounding = 0;
      dim_inactive = true;
      dim_strength = 0.24;

      shadow.enabled = false;

      blur = {
        enabled = true;
        size = 1;
        passes = 4;
        ignore_opacity = true;
        new_optimizations = true;
        vibrancy = 1.2;
        brightness = 1.1;
        contrast = 1.3;
        xray = false;
        noise = 0.0117;
      };
    };

    input = {
      kb_layout = "us";
      kb_options = "grp:alt_shift_toggle";
      repeat_delay = 300;
      numlock_by_default = 1;
      follow_mouse = 1;
      sensitivity = 1.0;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
      };
    };

    gestures = { workspace_swipe = "off"; };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      vfr = true;
      vrr = 2;
      enable_swallow = false;
      focus_on_activate = false;
    };

    binds = {
      workspace_back_and_forth = 1;
      allow_workspace_cycles = 1;
      pass_mouse_when_bound = 0;
    };

    # Could help when scaling and not pixelating
    xwayland = { force_zero_scaling = true; };
  };
}

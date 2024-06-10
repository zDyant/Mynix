{ ... } :
{

wayland.windowManager.hyprland =  {
  extraConfig = "


monitor=,preferred,auto,1
source = $HOME/.cache/wal/colors-hyprland.conf

dwindle {
  pseudotile = yes
  preserve_split = yes
  special_scale_factor = 0.8
}

master {
  new_is_master=1
  new_on_top=1
  mfact = 0.5
}

general {
  sensitivity=1.00
  apply_sens_to_raw=1
  gaps_in = 2
  gaps_out = 12
  border_size = 1
  resize_on_border = true
   
  col.active_border = 0xff444444
  col.inactive_border = rgba(000000A0)

  layout = dwindle
}

group {
  col.border_active = $color6

	groupbar {
	col.active = $color6
  }
}

decoration {
  rounding = 16
  active_opacity = 1.0
  inactive_opacity = 1.0
  fullscreen_opacity = 1.0

  dim_inactive = false
  dim_strength = 0.35

  drop_shadow=false
  shadow_range = 16
  shadow_render_power = 2
  shadow_offset = 2 2
  col.shadow = rgba(0C0E13A6)

  blur {
  enabled = true	
  size = 5
  passes = 4
  ignore_opacity = true
  new_optimizations = true
  noise = 0.03
  contrast = 1.3
  }
}
    


input {
  kb_layout=us
  kb_variant=
  kb_model=
  kb_options=grp:alt_shift_toggle
  kb_rules=
  repeat_rate=50
  repeat_delay=300
  numlock_by_default=1
  left_handed=0
  follow_mouse=1
  float_switch_override_focus=0

  touchpad {
    disable_while_typing=1
    natural_scroll=0 
    clickfinger_behavior=0
    middle_button_emulation=1
    tap-to-click=1
    drag_lock=0
          }
}

gestures {
  workspace_swipe = off
}

misc {
  disable_hyprland_logo = true
  disable_splash_rendering = true
  mouse_move_enables_dpms = true
  vrr = 2
  enable_swallow = true
  no_direct_scanout = true #for fullscreen games
  focus_on_activate = false
  swallow_regex = ^(kitty)$
  #disable_autoreload = true
}

binds {
  workspace_back_and_forth=1
  allow_workspace_cycles=1
  pass_mouse_when_bound=0
}

#Could help when scaling and not pixelating
xwayland {
    force_zero_scaling = true
}
debug {
  # Disable watchdog
  watchdog_timeout = 0
}
    ";
  };
}

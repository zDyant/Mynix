{
  config,
  lib,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  wayland.windowManager.hyprland.configType = "lua";
  wayland.windowManager.hyprland.settings = {
    monitor = [
      {
        output = "DP-2";
        mode = "3840x2160@144";
        position = "0x0";
        scale = 1.5;
        # bitdepth = 10;
        cm = "auto";
      }
      {
        output = "HDMI-A-1";
        mode = "1920x1080@144";
        position = "2560x0";
        scale = 1;
        cm = "auto";
      }
    ];

    config = {
      animations.enabled = true;
      ecosystem.no_donation_nag = true;

      master = {
        new_on_top = 1;
        mfact = 0.5;
      };

      general = {
        gaps_in = 4;
        gaps_out = 10;
        border_size = 4;
        resize_on_border = false;
        "col.active_border" = lib.mkDefault "rgb(${colors.base0A})";
        layout = "master";
      };

      group = {
        "col.border_active" = lib.mkDefault "rgb(${colors.base0A})";
        "col.border_inactive" = lib.mkDefault "rgb(${colors.base02})";

        groupbar = {
          gradients = true;
          font_family = config.stylix.fonts.sansSerif.name;
          font_weight_active = "heavy";
          font_size = 14;
          height = 20;
          text_color = lib.mkDefault "rgb(${colors.base00})";
          text_color_inactive = lib.mkDefault "rgb(${colors.base05})";
          "col.active" = lib.mkDefault "rgb(${colors.base0D})";
          "col.inactive" = lib.mkDefault "rgb(${colors.base00})";
        };
      };

      decoration = {
        rounding = 0;
        dim_inactive = true;
        dim_strength = 0.1;
        shadow.enabled = false;

        blur = {
          enabled = false;
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
        sensitivity = 0.8;

        scroll_method = "on_button_down";
        scroll_button = 274;

        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        vrr = 2;
        enable_swallow = false;
        focus_on_activate = false;
      };

      # Could help when scaling and not pixelating
      xwayland = {force_zero_scaling = true;};
    };
  };
}

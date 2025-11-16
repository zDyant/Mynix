{ config, inputs, pkgs, ... }: {
  imports = [ inputs.noctalia.homeModules.default ];

  wayland.windowManager.hyprland.settings.exec-once = [ "noctalia-shell" ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      general = {
        lockOnSuspend = true;
        radiusRatio = 0;
      };
      ui = {
        fontDefault = pkgs.geist-font;
        fontFixed = pkgs.maple-mono.NF;
      };
      location.name = "Sao Paulo, Brazil";
      dock.enabled = false;
      osd.autoHideMs = 1000;
      screenRecorder = {
        videoCodec = "av1";
        directory = "${config.xdg.dataHome}/Videos/capture";
      };

      bar = {
        density = "comfortable";
        position = "top";
        showCapsule = false;
        widgets = {
          left = [
            { id = "Spacer"; }
            { id = "MediaMini"; }
          ];
          center = [{
            hideUnoccupied = false;
            id = "Workspace";
            labelMode = "none";
          }];
          right = [
            {
              id = "Tray";
              colorizeIcons = true;
            }
            {
              formatHorizontal = "HH:mm ddd d";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
            { id = "ControlCenter"; }
            { id = "Spacer"; }
          ];
        };
      };
    };
    colors = with config.lib.stylix.colors; {
      mError            = "#${base08}";
      mOnError          = "#${base00}";
      mOnPrimary        = "#${base00}";
      mOnSecondary      = "#${base00}";
      mOnSurface        = "#${base06}";
      mOnSurfaceVariant = "#${base04}";
      mOnTertiary       = "#${base06}";
      mOutline          = "#${base0F}";
      mPrimary          = "#${base0A}";
      mSecondary        = "#${base0C}";
      mShadow           = "#${base00}";
      mSurface          = "#${base01}";
      mSurfaceVariant   = "#${base02}";
      mTertiary         = "#${base0B}";
    };
  };
}

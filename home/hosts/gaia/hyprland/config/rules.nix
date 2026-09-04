{lib, ...}: let
  inherit (import ./_helper.nix {inherit lib;}) expandRules mkRules;
in {
  wayland.windowManager.hyprland.settings = {
    layer_rule = expandRules [
      # INFO: Remove border around hyprshot screenshots
      {
        match.namespace = [
          "selection"
          "^(dms:.*)$"
        ];
        no_anim = true;
      }
    ];

    # Each tag: how a window earns it, and what that gets it.
    # anyOf — any one field is enough. allOf — all fields together.
    window_rule = mkRules {
      tags = {
        browsers = {
          anyOf.class = [
            "^([Ff]loorp)$"
            "^(brave-browser)$"
          ];
          apply.workspace = "1 silent";
        };

        games = {
          anyOf.class = [
            "^([Ss]team)$"
            "^(com.heroicgameslauncher.hgl)$"
            "^(gamescope|\\.gamescope-wrapped)$"
            "^(steam_app_.*)$"
          ];
          content = "game";
          apply = {
            workspace = "2 silent";
            no_blur = true;
            # render_unfocused = true;
          };
        };

        social = {
          anyOf.class = [
            "^(.*[Cc]ord)$"
          ];
          apply.workspace = "3";
        };

        media = {
          anyOf.class = [
            "^(mpv)$"
            "^([Ss]potify)$"
          ];
          apply.workspace = "5";
        };

        float = {
          anyOf.class = [
            "^(pavucontrol)$"
            "^(Authentication Required)$"
            "^(xdg-desktop-portal-gtk)$"
            "^(float)$"
            "org.gnome.FileRoller"
            "file-roller"
          ];
          anyOf.title = [
            "^(Select|Open)( a)? (File|Folder)(s)?$"
            "^File (Operation|Upload)( Progress)?$"
            "^.* Properties$"
            "^Export Image as PNG$"
            "^Save As$"
            "^Library$"
            "^Select the game's \\.exe$"
          ];
          apply = {
            float = true;
            size = "(monitor_w*0.5) (monitor_h*0.5)";
            center = true;
          };
        };
      };

      # Standalone rules, applied in order. Fields in `match` are AND.
      rules = [
        {
          match.fullscreen = true;
          idle_inhibit = "fullscreen";
        }
        # Anything floating gets centred.
        {
          match.float = true;
          center = true;
        }
        # Xwayland popups: no dim, no shadow.
        {
          match = {
            xwayland = true;
            title = "win[0-9]+";
          };
          no_dim = true;
          no_shadow = true;
        }
        {
          match.title = "^(Picture-in-Picture)$";
          float = true;
          size = "(monitor_w*0.2) (monitor_h*0.2)";
        }
      ];
    };
  };
}

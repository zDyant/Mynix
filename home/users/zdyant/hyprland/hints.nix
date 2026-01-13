{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "hints-once";
      runtimeInputs = with pkgs; [ util-linux ];
      bashOptions = [ "errexit" "nounset" "pipefail" ];
      text = ''
        #!/usr/bin/env bash
        # Single-instance guard using flock on XDG_RUNTIME_DIR / XDG_RUNTIME_DIR で flock による単一実行ガード
        lock_dir="''${XDG_RUNTIME_DIR:-/run/user/$UID}"
        lock_file="$lock_dir/hints-overlay.lock"
        exec ${pkgs.util-linux}/bin/flock -n "$lock_file" \
          env HINTS_WINDOW_SYSTEM=hyprland ${pkgs.hints}/bin/hints -m hint
      '';
    })

  ];

  wayland.windowManager.hyprland.settings = {
    bind = [ "CTRL, 2, exec, hints-once" ];
    # Layer rules
    # Disable animations for hints overlay.
    layerrule = [ "noanim, hints" ];

    env = [
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
      # Declare window system for hints / hints 用にウィンドウシステムを明示
      "HINTS_WINDOW_SYSTEM,hyprland"
    ];
  };

  # Hints UI config
  # Shrink overlay footprint.
  xdg.configFile."hints/config.json" = {
    text = builtins.toJSON {
      hints = {
        hint_height = 22; # Smaller than default 30
        hint_width_padding = 6; # Narrower than default 10
        hint_font_size = 12; # Smaller than default 15
        backends = { enable = [ "atspi" "opencv" ]; };
        overlay_x_offset = 0;
        overlay_y_offset = 0; # Offset upward by bar height
      };
    };
  };

  # hints daemon service
  systemd.user.services.hintsd = {
    Unit = {
      Description = "Hints daemon";
      After = [ "graphical-session.target" "at-spi-dbus-bus.service" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.hints}/bin/hintsd";
      Restart = "on-failure";
      Environment =
        [ "HINTS_WINDOW_SYSTEM=hyprland" "WAYLAND_DISPLAY=wayland-1" ];
    };
    Install = { WantedBy = [ "default.target" ]; };
  };

}

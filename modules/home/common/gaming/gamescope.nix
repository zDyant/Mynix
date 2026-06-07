{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.play.homeManagerModules.play];

  wayland.windowManager.hyprland.settings.windowrule = lib.mkIf config.wayland.windowManager.hyprland.enable [
    "tag +gamestore, match:class ^([Ss]team)$"
    "tag +gamestore, match:class ^(com.heroicgameslauncher.hgl)$"
    "tag +games, match:class ^(gamescope|\\.gamescope-wrapped)$"
    "tag +games, match:class ^(steam_app_.*)$"

    "no_blur on,     match:tag games*"
    "fullscreen on, match:tag games*"

    "workspace 2 silent, match:tag gamestore*"
    "workspace 2 silent, match:tag games*"
  ];

  play = {
    gamescoperun = {
      enable = true;
      useGit = lib.mkDefault true;
      defaultWSI = lib.mkDefault true;
      defaultHDR = lib.mkDefault null;

      baseOptions = lib.mkDefault {
        "fsr-upscaling" = lib.mkDefault false;
        "backend" = lib.mkDefault "wayland";
      };

      # Extra environment variables
      environment = {
        XCURSOR_THEME = config.home.pointerCursor.name or "Adwaita";
        XCURSOR_PATH = "${
          config.home.pointerCursor.package or pkgs.adwaita-icon-theme
        }/share/icons";
      };
    };

    wrappers = {
      steam = lib.mkDefault {
        enable = true;
        command = "${lib.getExe osConfig.programs.steam.package} -bigpicture -tenfoot";
        extraOptions = {"steam" = true;};
        environment = {
          GAMEMODERUN = "1";
          MESA_SHADER_CACHE_MAX_SIZE = "4096";
          WINEDLLOVERRIDES = "dinput8,dxgi,dsound,version=n,b";
          STEAM_FORCE_DESKTOPUI_SCALING = 1;
          STEAM_GAMEPADUI = 1;
        };
      };

      heroic = lib.mkDefault {
        enable = true;
        package = pkgs.heroic; # No special package configured by play.nix
      };
    };
  };

  # Simple wrapper package for native Steam client
  home.packages = [
    (pkgs.writeShellScriptBin "steam-client" ''
      exec ${lib.getExe osConfig.programs.steam.package} "$@"
    '')
  ];

  xdg.desktopEntries = {
    ## Steam and Games ##
    steam = lib.mkDefault {
      name = "Steam";
      exec = "${lib.getExe osConfig.programs.steam.package}";
      icon = "steam";
      type = "Application";
      terminal = false;
      categories = ["Game"];
      mimeType = ["x-scheme-handler/steam" "x-scheme-handler/steamlink"];
      settings = {
        StartupNotify = "true";
        StartupWMClass = "Steam";
        PrefersNonDefaultGPU = "true";
        X-KDE-RunOnDiscreteGpu = "true";
        Keywords = "gaming;";
      };

      actions = {
        native = {
          name = "Steam Big Picture (Gamescope with defaults)";
          exec = "${lib.getExe config.play.wrappers.steam.wrappedPackage}";
        };

        kill-processes = {
          name = "Kill Steam/Gamescope Processes";
          exec = "${pkgs.writeShellScript "kill-gaming-processes" ''
            set -e
            ${pkgs.procps}/bin/pkill -f "steam" || true
            ${pkgs.procps}/bin/pkill -f "gamescope" || true
            ${pkgs.procps}/bin/pkill -f "gamescopereaper" || true
            ${pkgs.libnotify}/bin/notify-send "Gaming Processes" "Killed steam, gamescope, and gamescopereaper processes"
          ''}";
        };
      };
    };

    ## Other Launchers ##
    "com.heroicgameslauncher.hgl" = lib.mkDefault {
      name = "Heroic Games Launcher";
      comment = "Heroic in Gamescope Session";
      exec = "${lib.getExe config.play.wrappers.heroic.wrappedPackage}";
      icon = "com.heroicgameslauncher.hgl";
      type = "Application";
      terminal = false;
      categories = ["Game"];
      actions = {
        native = {
          name = "Heroic (No Gamescope)";
          exec = "${lib.getExe pkgs.heroic}";
        };
      };
    };
  };
}

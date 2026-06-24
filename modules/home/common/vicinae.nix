{
  lib,
  config,
  ...
}: let
  vicinae = lib.getExe config.programs.vicinae.package;
in {
  wayland.windowManager.hyprland.settings.bind = lib.mkIf config.wayland.windowManager.hyprland.enable [
    "$mod, A, exec, ${vicinae} vicinae://launch/clipboard/history"
    "$mod, $mod_L, exec, ${vicinae} toggle"
  ];

  programs.vicinae = lib.mkDefault {
    enable = true;
    systemd.enable = true;
    systemd.autoStart = true;
    useLayerShell = true;

    settings = {
      faviconService = "twenty";
      popToRootOnClose = true;
      rootSearch.searchFiles = false;

      window = {
        csd = true;
        rounding = 0;
      };

      providers = {
        core.entrypoints = {
          sponsor.enabled = false;
          store.enabled = false;
          documentation.enabled = false; # Documentation links
          themeManager.enabled = false; # Theme browser
          oauth-token-store.enabled = false;
          report-bug.enabled = false;
        };
      };
    };
  };
}

{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];
  # ++ lib.fs.scanPaths ./.;
  programs.dank-material-shell = {
    enable = lib.mkDefault true;
    # inherit settings;
    # # inherit stylix except session
    # session = lib.mkForce (importJson "session");

    # DMS runtime owns mutable JSON state/settings, including plugin_settings.json.
    managePluginSettings = lib.mkDefault false;

    systemd = {
      enable = lib.mkDefault true;
      restartIfChanged = lib.mkDefault true;
    };

    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = false; # VPN management widget
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = false; # Calendar integration (khal)
    enableClipboardPaste = true; # Pasting items from the clipboard (wtype)
  };

  home.packages = with pkgs; [
    # Needed for the Home Assistant Monitor plugin's websocket connection.
    qt6.qtwebsockets
  ];
}

{pkgs, ...}: {
  stylix.targets.dank-material-shell.enable = false;

  home.packages = with pkgs; [
    # Needed for the Home Assistant Monitor plugin's websocket connection.
    qt6.qtwebsockets
  ];
}

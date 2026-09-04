{
  lib,
  pkgs,
  ...
}: {
  imports = lib.fs.scanPaths ./.;

  home.packages = with pkgs; [
    glib
    wl-clipboard
    xwayland
    wayland
    wayland-utils
    wayland-protocols
    wlroots
    libsForQt5.qt5ct
    direnv
    qt6.qtwayland
    playerctl
    hyprland-qtutils
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = null; # INFO: Set this to null if you use the NixOS module to install Hyprland.
    portalPackage = null;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # INFO:
    # UWSM owns the graphical-session targets. Home Manager's Hyprland
    # systemd integration creates a separate hyprland-session.target and can
    # produce ordering cycles during shutdown/restart.
    systemd.enable = false;
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {enable = true;};
  };
}

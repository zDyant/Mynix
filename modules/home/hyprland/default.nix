{ pkgs, ... }:

{
  imports = [
    ./config
    ./scripts
    ./scripts.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprcursor.nix
  ];

  home.packages = with pkgs; [
    networkmanagerapplet
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

  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    systemd.enable = true;
  };

  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      configPackages = [ pkgs.hyprland ];
    };
  };

}

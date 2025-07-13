{ pkgs, ... }:

{
  imports = [
    ./configs
    ./scripts
    ./scripts.nix
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprcursor.nix
  ];

  home.packages = with pkgs; [
    btop
    networkmanagerapplet
    swww
    hyprpicker
    grim
    slurp
    cliphist
    wl-clipboard
    glib
    xwayland
    wayland
    wayland-utils
    wayland-protocols
    wlroots
    libsForQt5.qt5ct
    direnv
    qt6.qtwayland
    cava
    # for wallpaper script
    xxHash
    bc
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
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      configPackages = [pkgs.hyprland];
    };
  };

}

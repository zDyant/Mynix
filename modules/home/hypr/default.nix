{ pkgs, ... }:

{
  imports = [
    ./configs
    ./scripts
    ./scripts.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    htop
    nvtopPackages.full
    gnome.gnome-system-monitor
    networkmanagerapplet
    blueman
    swww
    pywal
    hyprpicker
    grim
    slurp
    cliphist
    wl-clipboard
    wf-recorder
    glib
    xwayland
    wayland
    wayland-utils
    wayland-protocols
    wlroots
    qt5ct
    direnv
    qt6.qtwayland
    cava
  ];

  # systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # systemd.enable = true;
  };
}

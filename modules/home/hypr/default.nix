{ pkgs, ... }:

{
  imports = [
    ./configs
    ./scripts
    ./hyprlock.nix
    ./hypridle.nix
  ];

  home.packages = with pkgs; [
    swww
    waybar
    swaynotificationcenter
    wlogout
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
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      # hidpi = true;
    };
    # enableNvidiaPatches = false;
    systemd.enable = true;
  };
}

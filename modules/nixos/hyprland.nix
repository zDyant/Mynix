{ config, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    portalPackage = pkgs.xdg-desktop-portal-gtk;
  };

  services.displayManager.defaultSession =
    if config.programs.hyprland.withUWSM or false then
      "hyprland-uwsm"
    else
      "hyprland";

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs;
      [
        # xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        # xdg-desktop-portal-wlr
      ];
  };
}

{ config, lib, pkgs, ... }: {
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
    config.common.default = "wlr";
    wlr.enable = true;
    wlr.settings.screencast = {
      output_name = "DP-2";
      chooser_type = "simple";
      chooser_cmd = "${lib.getExe pkgs.slurp} -f 'Monitor: %o' -or";
    };
    xdgOpenUsePortal = true;
    extraPortals = with pkgs;
      [
        # xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
        # xdg-desktop-portal-wlr
      ];
  };
}

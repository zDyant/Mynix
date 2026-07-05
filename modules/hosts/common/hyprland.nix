{
  config,
  pkgs,
  ...
}: {
  # WARN: test if arroz-nix handles it, if not include on import
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  services.displayManager.defaultSession =
    if config.programs.hyprland.withUWSM or false
    then "hyprland-uwsm"
    else "hyprland";

  xdg.portal = {
    enable = true;
    config = {
      common.default = ["hyprland" "gtk"];
      hyprland = {
        default = ["hyprland" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [xdg-desktop-portal-gtk];
  };
}

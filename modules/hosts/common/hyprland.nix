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
        "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-termfilechooser
    ];
    xdgOpenUsePortal = true;
  };

  environment.etc."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.writeShellScript "yazi-wrapper" ''
      #!/usr/bin/env bash
      # $1 = output path, $2+ = paths passed by the portal (multiple/directory/save mode)
      OUT="$1"
      shift
      ${pkgs.kitty}/bin/kitty --class filechooser -e ${pkgs.yazi}/bin/yazi --chooser-file="$OUT" "$@"
    ''}
    default_dir=$HOME
  '';
}

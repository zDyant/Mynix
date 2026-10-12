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
  };

  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = let
    directoryConfig = pkgs.writeTextDir "keymap.toml" (builtins.readFile ./portal/keymap.toml);
    chooser = pkgs.writeShellApplication {
      name = "yazi-portal-chooser";
      runtimeInputs = [pkgs.kitty pkgs.yazi pkgs.coreutils];
      text = ''
        export PORTAL_DIRECTORY_CONFIG=${directoryConfig}
        ${builtins.readFile ./portal/chooser.sh}
      '';
    };
  in ''
    [filechooser]
    cmd=${chooser}/bin/yazi-portal-chooser
    default_dir=$HOME
  '';
}

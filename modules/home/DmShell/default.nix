{ inputs, ... }: {
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
  ];
  wayland.windowManager.hyprland.settings.exec-once = [ "dms run" ];
  programs.dankMaterialShell.enable = true;
}

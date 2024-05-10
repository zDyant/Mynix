{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink ./waybar; 
    recursive = true;
  };
}

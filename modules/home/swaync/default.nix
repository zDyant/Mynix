{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile."swaync" = {
    source = config.lib.file.mkOutOfStoreSymlink ./swaync;
    recursive = true;
  };
}

{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    swaynotificationcenter
  ];

  xdg.configFile."swaync" = {
    source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/home/swaync/swaync;
    recursive = true;
  };
}

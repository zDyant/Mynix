{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
  ];

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/home/waybar/waybar;
    recursive = true;
  };
}

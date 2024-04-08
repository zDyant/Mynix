{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wlogout
  ];

  xdg.configFile."wlogout" = {
    source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/home/wlogout/wlogout;
    recursive = true;
  };
}

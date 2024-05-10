{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    wlogout
  ];

  xdg.configFile."wlogout" = {
    source = config.lib.file.mkOutOfStoreSymlink ./wlogout;
    recursive = true;
  };
}

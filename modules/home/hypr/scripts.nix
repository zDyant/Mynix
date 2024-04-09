{ config, pkgs, ...}:
{
  xdg.configFile."hypr/scripts" = {
    source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/home/hypr/scripts;
    recursive = true;
  };
}

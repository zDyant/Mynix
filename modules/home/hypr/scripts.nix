{ config, pkgs, ...}:
{
  xdg.configFile."hypr/scripts" = {
    source = config.lib.file.mkOutOfStoreSymlink ./scripts; 
    recursive = true;
  };
}

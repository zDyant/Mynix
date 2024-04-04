{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    lazygit
  ];

  xdg.configFile."lvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/home/lvim/lvim;
    recursive = true;
  };

}

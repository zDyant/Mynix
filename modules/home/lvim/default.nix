{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    rustup
    python310Packages.pip
    sqlite.dev
    sqlite
	  meson
	  cmake
    gnumake
    gcc
    python3
    lazygit
  ];

  xdg.configFile."lvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/modules/home/lvim/lvim;
    recursive = true;
  };

}

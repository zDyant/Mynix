{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    lunarvim
    rustc
    cargo
    python310Packages.pip
    sqlite.dev
    sqlite
	  meson
	  cmake
    gnumake
    gcc
    python3
    lazygit
    yarn
  ];

  # xdg.configFile."lvim" = {
  #   source = config.lib.file.mkOutOfStoreSymlink ./lvim;
  #   recursive = true;
  # };

}

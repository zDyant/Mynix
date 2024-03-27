{ pkgs, ... }:

{
  imports = [
    ./zsh
    ./starship
    ./hypr
    ./bat
    ./gtk
    ./spicetify
    ./games
  ];

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vesktop
    rustup
    sqlite
	  kitty
    xfce.thunar
	  libnotify
	  floorp
	  git
    gh
	  meson
	  cmake
	  lunarvim
    eza
    git
    lazygit
    gcc
    gparted
    man-pages
    mpv
    unzip
    xdg-utils
    playerctl
    bitwarden
    jq
    python310Packages.pip
    unzip
    unrar
    motrix
    bottles
    obsidian
    element-desktop
    telegram-desktop
    btrfs-progs
  ];

  
  programs.home-manager.enable = true;
}

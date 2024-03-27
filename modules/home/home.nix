{ spicetify-nix, pkgs, ... }:

{
  imports = [
    ./zsh
    ./starship
    ./hypr
    ./bat
    ./gtk
    ./spotify
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
    steam
    gamemode
    winetricks
    unzip
    unrar
    motrix
    bottles
    obsidian
    adwsteamgtk
    element-desktop
    telegram-desktop
    btrfs-progs
    mesa
  ];

  
  programs.home-manager.enable = true;
}

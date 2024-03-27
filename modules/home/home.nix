{ config, pkgs, ... }:

{
  imports = [
    ./zsh
    ./starship
    ./hypr
    ./bat
    ./gtk
  ];
  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vesktop
    oh-my-zsh
    rustup
    sqlite
    bat
	  kitty
    xfce.thunar
	  libnotify
	  floorp
	  git
    gh
	  meson
	  cmake
	  lunarvim
    zsh
    starship
    eza
    git
    lazygit
    zoxide
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
    spotify
    bottles
    obsidian
    adwsteamgtk
    element-desktop
    telegram-desktop
    btrfs-progs
    mesa
  ];

  home.file = {
   # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}

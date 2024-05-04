{ pkgs, ... }:

{
  imports = [
    ./zsh
    ./starship
    ./hypr
    ./bat
    ./gtk
    ./lvim
    ./spicetify
    ./games
    ./rofi
    ./kitty
    ./wlogout
    ./swaync
    ./waybar
  ];

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    TERMINAL = "kitty";    
  };

  home.packages = with pkgs; [
  # Cli tools -----------------------------------------------
  ripgrep
  unrar
  unzip
  jq
  eza
  gh
  git
  feh
  mdadm
  appimage-run
  fd
  tgpt
  man-pages
  tlrc # tldr
  swappy
  imagemagick
  playerctl
  fzf
  nh
  # charm-freeze
  glow
  vhs
  ffmpeg

  # libs ---------------------------------------------------------
  xdg-utils
  libxkbcommon
  zlib
  zlib-ng
  pamixer
  libgnome-keyring
  btrfs-progs
  libarchive
  pkgconf
	libnotify
  libpkgconf
  openssl

  # Chatting ----------------------------------------------------- 
  element-desktop
  paper-plane # telegram
  vesktop # discord

  # Apps ---------------------------------------------------------
  gnome.file-roller
  gnome.nautilus
  gnome.eog
  gnome.gnome-keyring
  rnote
  rclone
	floorp
  mpv
  motrix
  obsidian
  pavucontrol
  evince
  ];

  programs.home-manager.enable = true;
}

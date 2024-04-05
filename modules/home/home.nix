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
  ];


  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    TERMINAL = "kitty";    
  };

  home.packages = with pkgs; [
  # Cli tools
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
  tlrc
  swappy
  imagemagick
	libnotify
  playerctl
  fzf

  vesktop
  cron
  rclone
  gnome.nautilus
  gnome.eog
	floorp
  mpv
  motrix
  obsidian
  element-desktop
  telegram-desktop
  btrfs-progs
  pavucontrol
  ffmpeg
  openssl
  pamixer
  xdg-utils
  ];

  
  programs.home-manager.enable = true;
}

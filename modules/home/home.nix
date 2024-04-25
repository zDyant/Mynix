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
  nh

  # charm-freeze
  glow
  vhs

  rnote
  vesktop
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
  libxkbcommon
  zlib
  zlib-ng
  steamtinkerlaunch
  ];

  
  programs.home-manager.enable = true;
}

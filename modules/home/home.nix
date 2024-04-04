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
  appimage-run
  qbittorrent
  vesktop
  tlrc
  cron
  rclone
  gnome.nautilus
    kdePackages.kate
    feh
    gnome.eog
    imagemagick
    mdadm
    swappy
	  libnotify
	  floorp
    gh
    eza
    git
    man-pages
    mpv
    unzip
    playerctl
    bitwarden
    jq
    unzip
    unrar
    motrix
    bottles
    obsidian
    element-desktop
    telegram-desktop
    btrfs-progs
    pavucontrol
    fzf
    ffmpeg
    openssl
    pamixer
    xdg-utils
    tgpt
    fd
    ripgrep
  ];

  
  programs.home-manager.enable = true;
}

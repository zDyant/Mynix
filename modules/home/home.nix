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
    kdePackages.kate
    feh
    gnome.eog
    imagemagick
    mdadm
    swappy
    vesktop
    rustup
    sqlite
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
    man-pages
    mpv
    unzip
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
    pavucontrol
    fzf
    python3
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

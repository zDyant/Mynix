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
    ./alacritty
    ./wlogout
    ./swaync
    ./waybar
  ];

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # DONT TOUCH! 

  home.sessionVariables = {

    TERMINAL = "kitty";    
    BROWSER = "floorp";

	# WLR_RENDERER = "vulkan";  # KEEP IT OFF, OTHERWISE HYPRLAND WON'T LAUNCH
	XDG_CURRENT_DESKTOP = "Hyprland";
	XDG_SESSION_DESKTOP = "Hyprland";
	XDG_SESSION_TYPE = "wayland";
	GTK_USE_PORTAL = "1";
    NIXOS_OZONE_WL = "1";
	NIXOS_XDG_OPEN_USE_PORTAL = "1";

	XDG_CACHE_HOME = "$HOME/.cache";
	XDG_CONFIG_HOME = "$HOME/.config";
	XDG_BIN_HOME = "$HOME/.local/bin";
	XDG_DATA_HOME = "$HOME/.local/share";
  };

  # Add to $PATH
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  # Check LIBS on configuration.nix
  home.packages = with pkgs; [
  # Cli tools -----------------------------------------------
  unrar
  unzip
  jq
  eza
  gh
  git
  feh
  tgpt
  man-pages
  tlrc # tldr
  swappy
  imagemagick
  playerctl
  nh
  matugen

  # libs ---------------------------------------------------------
  pamixer
  btrfs-progs
  libarchive
  pkgconf

  # Chatting ----------------------------------------------------- 
  telegram-desktop
  (vesktop.override { withSystemVencord = false; }) # discord

  # Apps ---------------------------------------------------------
  gnome.gnome-software
  gnome.file-roller
  gnome.nautilus
  gnome.eog
  gnome.gnome-keyring
  rnote
  rclone
  floorp
  librewolf
  mpv
  motrix
  obsidian
  pavucontrol
  evince
  authenticator
  protonvpn-gui
  ungoogled-chromium
  fragments
  planify
  charm-freeze
  ];

  programs.home-manager.enable = true;
}

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
    ./flatpak.nix
    ./stylix.nix
  ];

  programs.git = {
    enable = true;
    userName = "zDyant";
    userEmail = "dyant@proton.me";
  };

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # DONT TOUCH! 

  home.sessionVariables = {

    TERMINAL = "kitty";    
    BROWSER = "zen";

	# WLR_RENDERER = "vulkan";  # KEEP IT OFF, OTHERWISE HYPRLAND WON'T LAUNCH
	XDG_CURRENT_DESKTOP = "Hyprland";
	XDG_SESSION_DESKTOP = "Hyprland";
	XDG_SESSION_TYPE = "wayland";
	GTK_USE_PORTAL = "1";
    NIXOS_OZONE_WL = "1";
	NIXOS_XDG_OPEN_USE_PORTAL = "1";
  };

  # Add to $PATH
  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

  # Check LIBS on configuration.nix
  home.packages = with pkgs; [
  # Cli tools -----------------------------------------------
  jq
  gh
  feh
  tgpt
  man-pages
  tlrc # tldr
  swappy
  imagemagick
  playerctl
  nh
  matugen
  wf-recorder
  diff-so-fancy
  # rclone        # Backup to proton drive
  distrobox

  # Chatting ----------------------------------------------------- 
  telegram-desktop
  (vesktop.override { withSystemVencord = false; }) # discord

  # Apps ---------------------------------------------------------
  file-roller
  eog           # Image-viewer
  rnote         # Scratch pad
  mpv
  motrix        # DL/Torrent manager
  obsidian
  pavucontrol
  evince        # PDF reader
  authenticator # OTP manager
  # protonvpn-gui
  # planify     # Todo-List
  # unstable.zed-editor
  unstable.cosmic-files
  hyprpanel
  youtube-music
  # anki
  openrgb-with-all-plugins
  ];

  programs.home-manager.enable = true;
}

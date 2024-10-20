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

    # set bat theme for good
    BAT_THEME="matugen";
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

  # Chatting ----------------------------------------------------- 
  telegram-desktop
  (vesktop.override { withSystemVencord = false; }) # discord

  # Apps ---------------------------------------------------------
  gnome.file-roller
  gnome.eog     # Image-viewer
  gnome.gnome-keyring
  cinnamon.nemo-with-extensions
  rnote         # Scratch pad
  rclone        # Backup to proton drive
  floorp
  librewolf
  mpv
  motrix        # DL/Torrent manager
  obsidian
  pavucontrol
  evince        # PDF reader
  authenticator # OTP manager
  protonvpn-gui
  # planify     # Todo-List
  unstable.zed-editor
  hyprpanel
  youtube-music
  anki
  ];

  programs.home-manager.enable = true;
}

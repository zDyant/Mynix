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

  xdg.mimeApps.enable = true;
  xdg.mimeApps = {

    defaultApplications = {
      "inode/directory" =           "org.gnome.Nautilus.desktop";
      "text/html" =                 "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/http" =     "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/https" =    "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/about" =    "org.qutebrowser.qutebrowser.desktop";
      "x-scheme-handler/unknown" =  "org.qutebrowser.qutebrowser.desktop";
    };

  };

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {

    TERMINAL = "kitty";    
    BROWSER = "floorp";

	WLR_RENDERER = "vulkan";
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

  home.sessionPath = [
    "$HOME/.cargo/bin"
  ];

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
  element-desktop                                 # Matrix client
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
  mpv
  motrix
  obsidian
  pavucontrol
  evince
  authenticator
  protonvpn-gui
  ungoogled-chromium
  ];

  programs.home-manager.enable = true;
}

{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ./zsh
    ./starship
    ./hyprland
    ./bat
    ./nvim
    ./spicetify
    ./games
    ./kitty
    ./yazi
    ./git
    ./tmux
    ./stylix.nix
    ./nh.nix
    ./wallpaper-engine
    ./floorp
    ./mpv
    ./noctalia
    ./navi
    ./vicinae
  ];

  # Why I enabled this?
  gtk.enable = true;

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
  };

  # Add to $PATH
  home.sessionPath = [
    # needed 'cause of npm set prefix ~/.npm-global
    "$HOME/.npm-global/bin"
    "$HOME/.cargo/bin"
  ];

  # github.com/britter/nix-configuration/blob/abdf6168b2a435da6f8d8f14c2fe7893f390cb2d/home/benedikt.nix#L85
  # Run npm config set during activation to store prefix in ~/.npmrc
  home.activation.setNpmPrefix = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.nodejs}/bin/npm config set prefix "${config.home.homeDirectory}/.npm-global"
  '';

  # Check LIBS on configuration.nix
  home.packages = with pkgs; [
    # Cli tools -----------------------------------------------
    gh
    man-pages
    tlrc # tldr
    cht-sh # Cheatsheets
    cheat # Cheatsheets
    # matugen
    wf-recorder
    rclone # Backup to proton drive
    distrobox
    # unstable.opencode # Too old
    devbox # Ease the use of nix-shell
	imv
	zathura

    # Chatting -----------------------------------------------------
    legcord # Discord
    ferdium

    # Apps ---------------------------------------------------------
    file-roller
    eog # Image-viewer
    rnote # Scratch pad
    motrix # DL/Torrent manager
    obsidian # Love you obsidian
    pavucontrol
    evince # PDF reader
    authenticator # OTP manager
    # planify     # Todo-List
    unstable.zed-editor # Don't want to edit everything using vim
    unstable.cosmic-files # Die gnome
    youtube-music
    # anki
  ];

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # DONT TOUCH!

  programs.home-manager.enable = true;
}

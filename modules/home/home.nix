{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./zsh
    ./starship
    ./hyprland
    ./bat
    ./nvim
    ./spicetify
    ./gaming
    ./kitty
    ./yazi
    ./git
    ./tmux
    ./stylix.nix
    ./nh.nix
    ./wallpaper-engine
    ./floorp
    ./mpv
    ./navi
    ./vicinae
    ./nixcord
    ./DmShell
    ./npm
  ];

  # Why I enabled this?
  gtk.enable = true;

  home.sessionVariables = {
    # WLR_RENDERER = "vulkan";  # WARN: KEEP IT OFF, OTHERWISE HYPRLAND WON'T LAUNCH
  };

  # Check LIBS on configuration.nix
  home.packages = with pkgs; [
    # Cli tools -----------------------------------------------
    man-pages
    cht-sh # Cheatsheets
    cheat # Cheatsheets
    wf-recorder
    rclone # Backup to proton drive
    distrobox
    devenv # Ease the use of nix-shell
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
    stremio-enhanced
    brave
  ];

  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # DONT TOUCH!

  programs.home-manager.enable = true;
}

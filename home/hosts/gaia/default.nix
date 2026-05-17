{
  flakeRoot,
  lib,
  pkgs,
  host,
  ...
}: {
  imports = lib.flatten [
    (lib.fs.scanPaths ./.)
    (map (lib.fs.relativeTo flakeRoot) [
      "modules/home/common/floorp"
      "modules/home/common/gaming"
      "modules/home/common/mpv"
      "modules/home/common/nautilus"
      "modules/home/common/nixcord"
      "modules/home/common/yazi"
      "modules/home/common/affinity.nix"
      "modules/home/common/bat.nix"
      "modules/home/common/kitty.nix"
      "modules/home/common/npm.nix"
      "modules/home/common/spicetify.nix"
      "modules/home/common/stylix.nix"
      "modules/home/common/tldr.nix"
      "modules/home/common/tmux.nix"
      "modules/home/common/vicinae.nix"
      "modules/home/common/wallpaper-engine.nix"
      "modules/home/common/zsh.nix"
    ])
  ];

  # Why I enabled this?
  gtk.enable = true;
  home.sessionVariables = {
    # WLR_RENDERER = "vulkan";  # WARN: KEEP IT OFF, OTHERWISE HYPRLAND WON'T LAUNCH
  };

  # Check LIBS on configuration.nix
  home.packages = with pkgs; [
    # Cli tools -----------------------------------------------
    devenv # Ease the use of nix-shell

    # Apps ---------------------------------------------------------
    rnote # Scratch pad
    obsidian # Love you obsidian
    planify # Todo-List
    anki
    oxipng
    obs-studio
    filen-cli
    rclone
    protonmail-desktop
    bitwarden-desktop
  ];

  home.stateVersion = "23.11"; # DONT TOUCH!
}

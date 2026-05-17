{
  lib,
  pkgs,
  flakeRoot,
  ...
}: {
  # WARN: Remember to grab yours hardware-configuration.nix
  imports = lib.flatten [
    (lib.fs.scanPaths ./.)
    (map (lib.fs.relativeTo flakeRoot) [
      "modules/hosts/common/amd.nix"
      "modules/hosts/common/adb.nix"
      "modules/hosts/common/audio.nix"
      "modules/hosts/common/bluetooth.nix"
      "modules/hosts/common/docker.nix"
      "modules/hosts/common/flatpak.nix"
      "modules/hosts/common/gaming.nix"
      "modules/hosts/common/cache.nix"
      "modules/hosts/common/lix.nix"
      "modules/hosts/common/nextdns.nix"
      "modules/hosts/common/sunshine.nix"
      "modules/hosts/common/hyprland.nix"
    ])
  ];

  environment.systemPackages = with pkgs; [
    zlib
    zlib-ng
    libxkbcommon
    libnotify
    openssl
    appimage-run
    ffmpeg-full
    pamixer
    btrfs-progs
    libarchive
    pkgconf
    gnome-keyring
    # zathura     # Minimalist document Viewer
    # eog         # Image-viewer
    pavucontrol
    authenticator # OTP manager
    nurl # Nix fetchFromGitHub
    aria2 # DL/Torrent manager
    qbittorrent-enhanced
    man-pages
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.ratbagd.enable = true;

  # Several services -------------------------------------
  programs.nix-ld.enable = true;

  # For passwords
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.openssh.enable = true;
  services.hardware.openrgb.enable = true;

  # WARN Don't change -------------------------------------
  system.stateVersion = "23.11"; # Did you read the comment?

  # Some shenanigans --------------------------------------
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}

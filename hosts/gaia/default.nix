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
      "modules/host/common/amd.nix"
      "modules/host/common/adb.nix"
      "modules/host/common/audio.nix"
      "modules/host/common/bluetooth.nix"
      "modules/host/common/docker.nix"
      "modules/host/common/flatpak.nix"
      "modules/host/common/gaming.nix"
      "modules/host/common/terminal.nix"
    ])
  ];

  programs.dms-shell.enable = true;
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

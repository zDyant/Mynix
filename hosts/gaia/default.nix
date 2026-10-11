{
  lib,
  pkgs,
  ...
}: {
  # WARN: Remember to grab yours hardware-configuration.nix
  imports =
    [./config]
    ++ lib.features [
      "amd"
      "adb"
      "audio"
      "bluetooth"
      "docker"
      "flatpak"
      "gaming"
      "cache"
      "lix"
      "nextdns"
      "sunshine"
      "hyprland"
      "greeter"
      "floorp"
      "mpv"
      "nixcord"
      "yazi"
      "kitty"
      "npm"
      "spicetify"
      "stylix"
      "emyl"
      "tldr"
      "tmux"
      "wallpaper-engine"
      "dms"
      "xdg"
    ];

  environment.systemPackages = with pkgs; [
    ffmpeg-full
    pamixer
    btrfs-progs
    zathura # Minimalist document Viewer
    imv # Image-viewer
    pavucontrol
    authenticator # OTP manager
    nurl # Nix fetchFromGitHub
    man-pages
    pinentry-curses # needed by rbw
    devenv # easy nix-shell
    dsearch # needed by dms, great tool btw
  ];

  # For passwords
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;

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

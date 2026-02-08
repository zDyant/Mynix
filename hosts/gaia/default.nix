{ lib, inputs, pkgs, ... }:

{
  # WARN: Remember to grab yours hardware-configuration.nix
  imports = lib.fs.scanPaths ./.;

  environment.systemPackages = with pkgs; [
    xdg-utils
    zlib
    zlib-ng
    libxkbcommon
    libnotify
    openssl
    appimage-run
    ffmpeg
    pamixer
    btrfs-progs
    libarchive
    pkgconf
    gnome-keyring
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11 ------------------------------
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Bluetooth --------------------------------------------
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Several services -------------------------------------
  programs.nix-ld.enable = true;

  # For passwords
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.openssh.enable = true;
  services.hardware.openrgb.enable = true;

  # INFO: uinput for hintsd
  hardware.uinput.enable = true;
  # AT-SPI bridge
  # Required for hintsd accessibility scanning.
  services.gnome.at-spi2-core.enable = true;

  # Garbage collector ------------------------------------
  nix.gc = {
    automatic = true;
    dates = "weekly";
    randomizedDelaySec = "14m";
    options = "--delete-older-than 7d";
  };

  # WARN Don't change -------------------------------------
  system.stateVersion = "23.11"; # Did you read the comment?

  nix = { package = pkgs.lixPackageSets.stable.lix; };

  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.unstable-pkgs
      inputs.self.overlays.modifications
      inputs.self.overlays.lix
    ];
  };

  # Some shenanigans --------------------------------------
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8"; # Select internationalisation properties.

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };
}

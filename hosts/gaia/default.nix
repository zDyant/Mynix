{ lib, inputs, pkgs, ... }:

{
  # WARN: Remember to grab yours hardware-configuration.nix
  imports = lib.fs.scanPaths ./.;

  environment.systemPackages = with pkgs; [
    unrar
    unzip
    vim
    wget
    neovim
    curl
    xdg-utils
    zlib
    zlib-ng
    libxkbcommon
    libnotify
    openssl
    ripgrep
    fzf
    appimage-run
    fd
    ffmpeg
    eza
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

  # Several services -------------------------------------

  programs.nix-ld.enable = true;

  # For passwords
  services.gnome.gnome-keyring.enable = true;

  services.gvfs.enable = true;

  services.openssh.enable = true;

  services.hardware.openrgb.enable = true;

  # Flatpak ----------------------------------------------
  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Bluetooth --------------------------------------------
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  # Garbage collector ------------------------------------
  nix.gc = {
    automatic = true;
    dates = "weekly";
    randomizedDelaySec = "14m";
    options = "--delete-older-than 7d";
  };

  # Making sure /tmp is clear to avoid issues
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  # WE DONT WANT TO BUILD STUFF ON TMPFS
  # ITS NOT A GOOD IDEA
  systemd.services.nix-daemon = { environment.TMPDIR = "/var/tmp"; };

  # WARN Don't change -------------------------------------
  system.stateVersion = "23.11"; # Did you read the comment?

  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings = {
      # STFU
      warn-dirty = false;
      # https://bmcgee.ie/posts/2023/12/til-how-to-optimise-substitutions-in-nix/
      http-connections = 128;
      max-substitution-jobs = 128;
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      auto-optimise-store = true;
      max-jobs = "auto";

      # continue building derivations if one fails
      keep-going = true;

      experimental-features = [ "nix-command" "flakes" ];
    };

  };

  nixpkgs = {
    config.allowUnfree = true;
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

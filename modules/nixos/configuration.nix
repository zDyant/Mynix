# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  imports =
    [ 
    #!!! Remember to copy the new hardware-configuration file from /etc/nixos/
      ./hardware-configuration.nix
      ./gaming.nix
      ./bootloader.nix
      ./audio.nix
      ./hyprland.nix
      ./login-screen.nix
      ./network.nix
      ./sunshine.nix
      ./fonts.nix
      ./substituters.nix
    ];

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
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
    lact
    eza
    pamixer
    btrfs-progs
    libarchive
    pkgconf
    inputs.zen-browser.packages."${system}".default
  ];
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11 ------------------------------
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Several services -------------------------------------
  
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

  # AMD Gpu Control
  systemd.services.lactd.wantedBy = ["multi-user.target"];
  systemd.packages = with pkgs; [ lact ];

  # Bluetooth --------------------------------------------
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;

  # Users ------------------------------------------------
  users.users.zdyant = {
    isNormalUser = true;
    description = "zDyant";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # Garbage collector ------------------------------------
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # WARN Don't change -------------------------------------
  system.stateVersion = "23.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  
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

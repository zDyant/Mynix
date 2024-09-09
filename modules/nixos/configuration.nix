# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

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
      ./fonts.nix
      ./substituters.nix
    ];

  users.users.zdyant = {
    isNormalUser = true;
    description = "zDyant";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

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

  services.gnome.gnome-keyring.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.gvfs.enable = true;
  
  
  systemd.services.lactd.wantedBy = ["multi-user.target"];
  systemd.packages = with pkgs; [ lact ];

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
  ];

}

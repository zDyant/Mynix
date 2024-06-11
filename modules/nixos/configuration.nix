# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./gaming.nix
      ./bootloader.nix
      ./audio.nix
      ./hyprland.nix
      ./login-screen.nix
      ./network.nix
      ./fonts.nix
    ];
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    cmake
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.gvfs.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zdyant = {
    isNormalUser = true;
    description = "zDyant";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
 };
 programs.zsh.enable = true;

  # Enable automatic login for the user.
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    neovim  
    curl
    xdg-utils
];

  services.openssh.enable = true;
  system.stateVersion = "23.11"; # Did you read the comment?
}

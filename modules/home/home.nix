{ config, pkgs, ... }:

{
  imports = [
    ./zsh
    ./starship
    ./hypr
  ];
  home.username = "zdyant";
  home.homeDirectory = "/home/zdyant";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    vesktop
    oh-my-zsh
    bibata-cursors
    rustup
    sqlite
    bat
	  kitty
    xfce.thunar
	  libnotify
	  floorp
	  git
    gh
	  meson
	  cmake
	  lunarvim
    zsh
    starship
    eza
    git
    lazygit
    zoxide
    gcc
    gparted
    man-pages
    mpv
    unzip
    xdg-utils
    playerctl
    bitwarden
    jq
    python310Packages.pip
    nerdfonts
    fira-code
    fira-code-symbols
  ];

  home.file = {
   # '';
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}

{ pkgs, ... }:
{

  home.packages = with pkgs; [
    heroic
    gamescope
    adwsteamgtk
    winetricks
    mesa
    mangohud
  ];
  
}

{ pkgs, ... }:
{

  home.packages = with pkgs; [
    gamemode
    gamescope
    adwsteamgtk
    winetricks
    mesa
    mangohud
  ];
  
}

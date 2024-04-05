{ pkgs, ... }:
{

  home.packages = with pkgs; [
    bottles
    heroic
    gamescope
    adwsteamgtk
    winetricks
    mesa
    mangohud
  ];
  
}

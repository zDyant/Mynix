{ pkgs, ... }:
{

  home.packages = with pkgs; [
    gamescope
    adwsteamgtk
    winetricks
    mesa
    mangohud
  ];
  
}

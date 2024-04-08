{ pkgs, ... }:
{

  home.packages = with pkgs; [
    bottles
    heroic
    gamescope
    adwsteamgtk
    wineWowPackages.staging
    winetricks
    mesa
    mangohud
  ];
  
}

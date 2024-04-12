{ pkgs, ... }:
{

  home.packages = with pkgs; [
    protontricks
    protonup-qt
    bottles
    heroic
    gamescope
    adwsteamgtk
    wineWowPackages.waylandFull
    winetricks
    mesa
    mangohud

    # emulators
    pcsx2
    # rpcs3
    ryujinx
  ];
  
}

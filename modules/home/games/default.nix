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
    steamtinkerlaunch


    # emulators
    pcsx2
    # rpcs3
    ryujinx
  ];
  
}

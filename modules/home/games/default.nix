{ pkgs, ... }:
{

  home.packages = with pkgs; [
    protontricks
    protonup-qt
    bottles
    heroic
    gamescope
    adwsteamgtk
    wineWowPackages.stagingFull
    winetricks
    mesa
    mangohud
    steamtinkerlaunch
    xivlauncher
    gamemode
    sunshine

    # emulators
    pcsx2
    # rpcs3
    ryujinx
  ];
  
}

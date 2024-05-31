{ pkgs, ... }:
{

  home.packages = with pkgs; [
    protonup-qt
    heroic
    gamescope
    adwsteamgtk # Theme for steam
    wineWowPackages.stagingFull # Don't change!!!, wayland version is broken
    mesa
    mangohud
    steamtinkerlaunch
    xivlauncher
    sunshine
    lutris
    moonlight-qt

    # emulators -----------------------
    pcsx2   # PS2
    # rpcs3   # PS3
    cemu    # Wii u
    ryujinx # Switch
  ];
  
}

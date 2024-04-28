{ pkgs, ... }:
{

  home.packages = with pkgs; [
    protonup-qt
    bottles
    heroic
    gamescope
    adwsteamgtk
    wineWowPackages.stagingFull
    mesa
    mangohud
    steamtinkerlaunch
    xivlauncher
    sunshine
    lutris

    # emulators
    pcsx2
    # rpcs3
    ryujinx
  ];
  
}

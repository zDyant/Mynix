{pkgs, ...}: {
  monitors = [
    {
      name = "DP-2";
      primary = true;
      width = 1920;
      height = 1080;
      refreshRate = 144;
      hdr = true;
      vrr = true;
    }
  ];

  home.packages = with pkgs; [
    adwsteamgtk # Theme for steam
    # hydralauncher
    # xivlauncher
    # moonlight-qt
    # unstable.nexusmods-app

    # emulators -----------------------
    # emulationstation-de
    # pcsx2           # PS2
    # retroarchFull   # Retro
    # rpcs3           # PS3
    # cemu            # Wii u
  ];
}

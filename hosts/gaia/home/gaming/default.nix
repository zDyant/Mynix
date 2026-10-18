{pkgs, ...}: {
  programs.wayscope.monitors = {
    main = {
      width = 3840;
      height = 2160;
      refreshRate = 144;
      hdr = true;
      vrr = true;
      primary = true;
    };
  };

  home.packages = with pkgs; [
    adwsteamgtk # Theme for steam
    # hydralauncher
    # xivlauncher
    # moonlight-qt
    # unstable.nexusmods-app

    # emulators -----------------------
    # emulationstation-de
    pcsx2 # PS2
    # retroarchFull # Retro
    xenia-canary # Xbox
    rpcs3 # PS3
    cemu # Wii u
  ];
}

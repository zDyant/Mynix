{ pkgs, ... }:
{
  imports = [
    ./gamescope.nix
    # ./switch.nix
  ];

  home.packages = with pkgs; [
    protonup-qt
    adwsteamgtk # Theme for steam
    steamtinkerlaunch
    wineWowPackages.stagingFull # Don't change!!!, wayland version is broken
    hydralauncher
    # xivlauncher

    # INFO: installed using play.nix
    # lutris
    # heroic

    # moonlight-qt
    # prismlauncher
    # jdk21
    # unstable.nexusmods-app

    # emulators -----------------------
    # emulationstation-de
    # pcsx2           # PS2
    # retroarchFull   # Retro
    # rpcs3           # PS3
    # cemu            # Wii u
  ];

  programs.mangohud = {
    enable = true;
    settings = {
      preset = 3;
    };
  };
}

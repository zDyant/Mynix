{ pkgs, lib, ... }: 
{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
  ];

  programs.gamemode = {
   enable = true;
   enableRenice = true;
   settings = {

    custom = {
      start = "notify-send -a 'Gamemode' 'Optimizations activated'";
      end = "notify-send -a 'Gamemode' 'Optimizations deactivated'";
    };
   };
  };
}


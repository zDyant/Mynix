{ lib, ... }: 
{

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
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
      start = "notify-send -a 'Gamemode' 'Gamemode ON' ";
      end = "notify-send -a 'Gamemode' 'Gamemode OFF' ";
    };
   };
  };
}


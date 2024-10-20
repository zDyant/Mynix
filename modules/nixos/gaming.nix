{ pkgs, lib, ... }: 
{

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];

  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];

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

  services.zerotierone = {
    enable = true;
    joinNetworks = [ 
      "e3918db483703b19"
      "3efa5cb78a814c49"
    ];
  };


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


{ pkgs, lib, ... }: 
{

  hardware.graphics = {
    enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Enabiling this makes gamescope unsuable
  # https://github.com/ValveSoftware/gamescope/issues/1349
  # https://github.com/ValveSoftware/gamescope/issues/1465
  # hardware.graphics.extraPackages = with pkgs; [ amdvlk ];
  # hardware.graphics.extraPackages32 = with pkgs; [ driversi686Linux.amdvlk ];

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
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


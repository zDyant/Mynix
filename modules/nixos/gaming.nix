{ inputs, pkgs, ... }:
{
  imports = [ inputs.play.nixosModules.play ];

  hardware.graphics = {
    enable = true;
  };

  play = {
    amd.enable = true;
    ananicy.enable = true;
    gamemode.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
}

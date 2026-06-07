{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.play.nixosModules.play];

  play = {
    amd.enable = true;
    ananicy.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };

  # Additional packages not covered by nixosModules
  environment.systemPackages = with pkgs; [
    heroic
  ];
}

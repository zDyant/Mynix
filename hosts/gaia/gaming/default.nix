{ inputs, pkgs, ... }: {
  imports = [ inputs.play.nixosModules.play ];

  # AMD Gpu Control
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  systemd.packages = with pkgs; [ lact ];

  environment.systemPackages = with pkgs; [ lact ];

  hardware.graphics = { enable = true; };

  play = {
    amd.enable = true;
    ananicy.enable = true;
    gamemode.enable = true;
    lutris.enable = true;
    steam.enable = true;
  };
}

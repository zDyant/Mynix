{ pkgs, ... }:
{
  # AMD Gpu Control
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];
  systemd.packages = with pkgs; [ lact ];

  environment.systemPackages = with pkgs; [ lact ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}

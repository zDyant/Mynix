{ pkgs, ... }:
{
  boot.loader.grub = {
    device = "/dev/nvme0n1";
    theme = pkgs.catppuccin-grub.override {
      flavor = "mocha";
    };
  };

  boot.plymouth = {
    enable = true;
    themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
    theme = "catppuccin-mocha";
  };

}

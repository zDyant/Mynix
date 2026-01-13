{ pkgs, ... }:
{
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd = {
    systemd.enable = true;
    verbose.enable = false;
  };

  boot.kernelParams = [
    "splash"
    "quiet" # SFTU
  ];

  boot.loader.timeout = 1;
  boot.loader.grub = {
    enable = true;
    # WARN: Prevent /boot from overflowing
    configurationLimit = 10;
    efiSupport = true;
    useOSProber = true;
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

{ pkgs, ... }:
{
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd = {
    systemd.enable = true;
    verbose.enable = false;
  };

  # Don't show command line arguments on boot
  boot.kernelParams = [
    "splash"
    "quiet"
  ];

  boot.loader.timeout = 1;
  boot.loader.grub = {
    enable = true;
    # Prevent /boot from overflowing
    configurationLimit = 10;
    efiSupport = true;
    useOSProber = true;
    device = "/dev/nvme0n1";

    theme = pkgs.catppuccin-grub.override {
      flavor = "mocha";
    };
  };

  # boot.plymouth = {
  #   enable = true;
  #   themePackages = [ (pkgs.catppuccin-plymouth.override {variant = "mocha";})];
  #   theme = "catppuccin-mocha";
  # };

}

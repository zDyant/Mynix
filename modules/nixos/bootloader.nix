{ pkgs, ... }:
{
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  # Don't show command line arguments on boot
  boot.kernelParams = [ "splash" "quiet" ];
  boot.loader.grub = {
    enable = true;
    # Prevent /boot from overflowing
    configurationLimit = 10;
    efiSupport = true;
    useOSProber = true;
    device = "/dev/sdb";

    theme = pkgs.stdenv.mkDerivation {
      pname = "catppuccin-grub";
      version = "1.0";
      src = pkgs.fetchFromGitHub
        {
          owner = "catppuccin";
          repo = "grub";
          rev = "88f6124";
          sha256 = "sha256-e8XFWebd/GyX44WQI06Cx6sOduCZc5z7/YhweVQGMGY=";
        };
      installPhase = "cp -r src/catppuccin-mocha-grub-theme $out";
    };
  };

  # boot.plymouth = {
  #   enable = true;
  #   themePackages = [ (pkgs.catppuccin-plymouth.override {variant = "mocha";})];
  #   theme = "catppuccin-mocha";
  # };

}

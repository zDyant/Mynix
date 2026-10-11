{lib, ...}: {
  boot.initrd = {
    systemd.enable = true;
    verbose.enable = false;
  };
  boot.kernelParams = [
    "splash"
    "quiet" # SFTU
  ];

  boot.loader = {
    efi.canTouchEfiVariables = lib.mkDefault true;
    timeout = lib.mkDefault 1;
    grub = {
      enable = lib.mkDefault true;
      # WARN: Prevent /boot from overflowing
      configurationLimit = lib.mkDefault 10;
      efiSupport = lib.mkDefault true;
      useOSProber = lib.mkDefault true;
    };
  };
}

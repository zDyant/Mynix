{
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot.kernelParams = ["net.ifnames=0"];
  boot.initrd.availableKernelModules = ["ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod"];
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
}

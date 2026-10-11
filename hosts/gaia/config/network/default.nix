{...}: {
  # Stop preventing Nix from building
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}

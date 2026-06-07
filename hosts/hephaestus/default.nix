{lib, ...}: {
  imports = lib.fs.scanPaths ./.;
  time.timeZone = "UTC";

  # environment.systemPackages = with pkgs; [ ];

  # Only for root's password reset on hetzner
  services.qemuGuest.enable = true;
}

{
  lib,
  flakeRoot,
  ...
}: {
  imports = lib.flatten [
    (lib.fs.scanPaths ./.)
    (map (lib.fs.relativeTo flakeRoot) [
      "modules/hosts/common/cache.nix"
    ])
  ];
  time.timeZone = "UTC";

  # environment.systemPackages = with pkgs; [ ];

  # Only for root's password reset on hetzner
  services.qemuGuest.enable = true;
}

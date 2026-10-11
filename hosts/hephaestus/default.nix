{lib, ...}: {
  imports =
    [
      ./hardware.nix
      ./config
    ]
    ++ lib.features [
      "cache"
      "docker"
      "homelab"
    ];
  time.timeZone = "UTC";

  # environment.systemPackages = with pkgs; [ ];

  # Only for root's password reset on hetzner
  services.qemuGuest.enable = true;
}

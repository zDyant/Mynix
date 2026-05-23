{lib, ...}: {
  imports = lib.fs.scanPaths ./.;
  time.timeZone = "UTC";

  # environment.systemPackages = with pkgs; [ ];
  programs.nix-ld.enable = true;

  # Only for root's password reset on hetzner
  services.qemuGuest.enable = true;

  };
}

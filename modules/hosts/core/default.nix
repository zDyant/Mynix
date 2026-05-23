{
  lib,
  pkgs,
  ...
}: {
  imports = lib.fs.scanPaths ./.;

  environment.systemPackages = with pkgs; [
    jq
    ripgrep
    fzf
    eza
    curl
    wget
    unrar
    unzip
    fd
    yazi
  ];

  documentation.nixos.enable = lib.mkForce false;
  nix = {
    # Garbage collector ------------------------------------
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB
      download-buffer-size = 2147483648; # 2GB
      auto-optimise-store = true;

      # STFU
      warn-dirty = false;

      # https://bmcgee.ie/posts/2023/12/til-how-to-optimise-substitutions-in-nix/
      http-connections = 128;
      max-substitution-jobs = 128;
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      max-jobs = "auto";
      allow-import-from-derivation = true;
      trusted-users = [ "@wheel" ];

      # continue building derivations if one fails
      keep-going = true;
      experimental-features = ["nix-command" "flakes"];

      substituters = [
        "https://cache.nixos.org"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
  # Making sure /tmp is clear to avoid issues
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;

  # WE DONT WANT TO BUILD STUFF ON TMPFS
  # ITS NOT A GOOD IDEA
  systemd.services.nix-daemon = {environment.TMPDIR = "/var/tmp";};

  # WARN: Don't change -------------------------------------
  system.stateVersion = "23.11"; # Did you read the comment?
}

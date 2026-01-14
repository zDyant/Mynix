{ lib, pkgs, ... }: {

  imports = lib.fs.scanPaths ./.;

  environment.variables.EDITOR = "nvim";
  programs.zsh.enable = true;
  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    ripgrep
    fzf
    eza
    curl
    neovim
    vim
    wget
    unrar
    unzip
    fd
    yazi
    git
  ];

  nix = {
    settings = {
      # STFU
      warn-dirty = false;
      # https://bmcgee.ie/posts/2023/12/til-how-to-optimise-substitutions-in-nix/
      http-connections = 128;
      max-substitution-jobs = 128;
      # use binary cache, its not gentoo
      builders-use-substitutes = true;
      auto-optimise-store = true;
      max-jobs = "auto";
      # continue building derivations if one fails
      keep-going = true;

      experimental-features = [ "nix-command" "flakes" ];

      substituters = [ "https://cache.nixos.org" ];

      trusted-public-keys =
        [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
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
  systemd.services.nix-daemon = { environment.TMPDIR = "/var/tmp"; };
}

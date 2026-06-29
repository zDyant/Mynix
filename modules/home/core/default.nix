{
  lib,
  host,
  ...
}: let
  user = host.user;
in {
  imports = lib.fs.scanPaths ./.;

  home = {
    username = lib.mkDefault user.name;
    stateVersion = "23.11"; # DONT TOUCH!
  };

  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "suggest";
}

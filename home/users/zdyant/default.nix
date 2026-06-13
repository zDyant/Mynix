{lib, ...}: {
  imports = lib.fs.scanPaths ./.;
  # Why though
  programs.nushell.enable = true;
  programs.starship.enable = true;
  programs.starship.enableNushellIntegration = true;
}

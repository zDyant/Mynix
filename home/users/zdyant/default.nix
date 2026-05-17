{lib, ... }: {
  imports = lib.fs.scanPaths ./.;
  # Why though
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.starship.enableZshIntegration = true;
}

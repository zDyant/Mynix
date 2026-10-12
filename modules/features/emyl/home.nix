{inputs, ...}: {
  imports = [inputs.emyl-nix.homeManagerModules.default];

  # theme.tui = {
  #   enable = true;
  #   hyprland.enable = true;
  #   nixcord.enable = true;
  #   spicetify.enable = true;
  #   mpv.enable = true;
  #   dms.enable = true;
  #   firefox.enable = true;
  # };
  theme.material = {
    starship.enable = true;
    nixcord.enable = true;
    hyprland.enable = true;
    mpv.enable = true;
    dms.enable = true;
    yazi.enable = true;
  };

  # theme.firefox = {
  #   userStyles.enable = true;
  #   unroundEverything.enable = true;
  # };
}

{ pkgs, spicetify-nix, ... }:

let spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [ spicetify-nix.homeManagerModule ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Bloom;
    colorScheme = "darkgreen";
    enabledCustomApps = with spicePkgs.apps; [ marketplace reddit ];
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      fullAppDisplay
      adblock
      autoSkipVideo
      shuffle
      trashbin
      playNext
      autoSkip
    ];
  };
}

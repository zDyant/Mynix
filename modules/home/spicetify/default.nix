{ pkgs, inputs, ... }:

let 
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ 
	inputs.spicetify-nix.homeManagerModules.default
  ];
  programs.spicetify = {
    enable = true;
    # spicetifyPackage = inputs.nixpkgs-unstable.legacyPackages."${pkgs.system}".spicetify-cli;
    theme = spicePkgs.themes.text;
    # colorScheme = "darkgreen";
    enabledCustomApps = with spicePkgs.apps; [ marketplace ];
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

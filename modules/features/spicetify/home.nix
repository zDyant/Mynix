{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
in {
  stylix.targets.spicetify.enable = false;
  programs.spicetify = {
    enable = true;

    theme = lib.mkForce (spicePkgs.themes.default // {name = "marketplace";});
    enabledCustomApps = with spicePkgs.apps; [marketplace];
    enabledExtensions = with spicePkgs.extensions; [
      # INFO: https://spicetify.app/docs/advanced-usage/extensions/#keyboard-shortcut
      autoVolume
      keyboardShortcut
      hidePodcasts
      adblock
      autoSkipVideo
      shuffle
      playNext
      autoSkip
      loopyLoop
      sectionMarker
      skipAfterTimestamp
      aiBandBlocker
      madeForYouShortcut
    ];
  };
}

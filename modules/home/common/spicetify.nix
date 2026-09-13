# https://github.com/adam01110/infra/blob/6e2c76c12162068a05b0b725816b47738f6b2a1c/modules/programs/gui/spotify/theme.nix#
{
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
    enable = true;

    # enabledCustomApps = with spicePkgs.apps; [ ];
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

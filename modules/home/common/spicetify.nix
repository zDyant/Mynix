# https://github.com/adam01110/infra/blob/6e2c76c12162068a05b0b725816b47738f6b2a1c/modules/programs/gui/spotify/theme.nix#
{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
  inherit (config.lib.stylix) colors;

  font = config.stylix.fonts.monospace.name;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];
  stylix.targets.spicetify.enable = false;

  programs.spicetify = lib.mkDefault {
    enable = true;
    theme = {
      name = "stylix";
      inherit (spicePkgs.themes.text) src;
      additionalCss =
        #css
        ''
          :root {
          --font-family: '${font}', monospace !important;
          --display-card-image: block !important;
          --display-coverart-image: block !important;
          --display-header-image: block !important;
          --display-sidebar-image: block !important;
          --display-tracklist-image: block !important;
          --border-transition: 0s !important;
          }
                    .Root__globalNav,
          .main-yourLibraryX-entryPoints,
          .Root__main-view,
          .main-nowPlayingBar-container,
          .Root__right-sidebar:has(aside:not(:empty)) {
            transition: none !important;
          }

          .Root__globalNav::before,
          .Root__nav-bar .main-yourLibraryX-entryPoints::before,
          .Root__main-view::before,
          .main-nowPlayingBar-container::before,
          .Root__right-sidebar:has(aside:not(:empty))::before {
            transition: none !important;
          }

          .player-controls__buttons,
          .main-nowPlayingBar-extraControls,
          .main-connectBar-connectBar {
            opacity: 1 !important;
            transition: none !important;
          }

          *,
          *::before,
          *::after {
            border-radius: 0px !important;
          }

          .view-homeShortcutsGrid-shortcuts::before {
            content: "" !important;
          }
        '';
    };
    colorScheme = "custom";
    customColorScheme = with colors; {
      accent = base0C;
      accent-active = base0D;
      accent-inactive = base01;
      text = base05;

      banner = base0C;
      border-active = base0A;
      border-inactive = base02;
      header = base03;
      highlight = base02;
      main = base00;
      notification = base0C;
      notification-error = base08;
      subtext = base04;
      button = base04;
      button-active = base04;
      button-disabled = base03;
      card = base03;
      equalizer = base0C;
      highlight-elevated = base03;
      main-elevated = base02;
      misc = base02;
      player = base04;
      selected-row = base04;
      shadow = base00;
      sidebar = base01;
      tab-active = base02;
    };

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

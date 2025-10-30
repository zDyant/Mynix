{ config, pkgs, inputs, ... }:

let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.text;
    colorScheme = "custom";
    customColorScheme = with config.lib.stylix.colors; {
      "accent"             = "${base0A}";
      "accent-active"      = "${base0A}";
      "accent-inactive"    = "${base01}";
      "banner"             = "${base0A}";
      "border-active"      = "${base0A}";
      "border-inactive"    = "${base02}";
      "header"             = "${base03}";
      "highlight"          = "${base07}";
      "main"               = "${base00}";
      "notification"       = "${base0B}";
      "notification-error" = "${base08}";
      "subtext"            = "${base04}";
      "text"               = "${base05}";
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
    ];
  };
}

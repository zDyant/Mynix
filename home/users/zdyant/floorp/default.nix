{ lib, inputs, config, pkgs, ... }:
let
  colorScheme = lib.getAttrs (map (n: "base0${toString n}")
    ((lib.range 0 9) ++ [ "A" "B" "C" "D" "E" "F" ])) config.lib.stylix.colors;
in {
  imports = [ ./search.nix ./extensions.nix ./settings.nix ./policies.nix ];
  stylix.targets.floorp.enable = false;

  home.sessionVariables = { BROWSER = "floorp"; };
  programs.floorp = {
    enable = true;
    nativeMessagingHosts = [ pkgs.tridactyl-native ];

    profiles.zdyant = {
      id = 0;
      isDefault = true;
      name = "zdyant";
      extraConfig = ''
        ${builtins.readFile "${inputs.betterfox}/user.js"}
        ${builtins.readFile "${inputs.betterfox}/Fastfox.js"}
        ${builtins.readFile "${inputs.betterfox}/Peskyfox.js"}
        ${builtins.readFile "${inputs.betterfox}/Smoothfox.js"}
        user_pref("shyfox.enable.ext.mono.toolbar.icons", true);
        user_pref("shyfox.enable.ext.mono.context.icons", true);
      '';
      userChrome = builtins.readFile "${inputs.textfox}/chrome/userChrome.css";
      userContent = let
      in ''
        ${builtins.readFile "${inputs.textfox}/chrome/userContent.css"}
        ${builtins.readFile
        "${inputs.userstyles.packages.${pkgs.system}.mkUserStyles colorScheme [
          "chatgpt"
          "claude"
          "duckduckgo"
          "github"
          "nixos-*"
          "reddit"
          "stack-overflow"
          "wikipedia"
          "youtube"
          "alternativeto"
          "anilist"
          "gmail"
          "google-*"
          "google"
          "home-manager-options-search"
          "proton"
          "wiki.nixos.org"
        ]}"}
      '';
    };
  };

  home.file."${config.home.homeDirectory}/.floorp/${config.home.username}/chrome/" =
    {
      source = "${inputs.textfox}/chrome";
      recursive = true;
      force = true;
    };

  home.file."${config.home.homeDirectory}/.floorp/${config.home.username}/chrome/config.css".text =
    # css
    ''
          :root {
        --tf-accent: #${config.lib.stylix.colors.base0A}; /* Accent color used, eg: color when hovering a container  */
        --tf-bg    : #${config.lib.stylix.colors.base00}; /* Background color of all elements, tab colors derive from this */
        --tf-border: #${config.lib.stylix.colors.base02}; /* Border color when not hovered */
        --tf-border-width: 1px; /* Width of borders */
      }
    '';

}

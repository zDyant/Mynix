{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = lib.fs.scanPaths ./.;
  stylix.targets.floorp.enable = false;

  home.sessionVariables = {BROWSER = "floorp";};
  programs.floorp = {
    enable = true;
    nativeMessagingHosts = [pkgs.tridactyl-native];

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
        system = pkgs.stdenv.hostPlatform.system;
        palette = config.lib.stylix.colors.withHashtag;
        userStyles = inputs.userstyles.lib.${system}.mkUserStyles palette;
      in ''
        ${builtins.readFile "${inputs.textfox}/chrome/userContent.css"}
        ${builtins.readFile userStyles}
      '';
    };
  };

  home.file."${config.home.homeDirectory}/.floorp/${config.home.username}/chrome/" = {
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

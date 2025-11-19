{ config, pkgs, ... }:
let
  textfox = pkgs.fetchFromGitHub {
    "owner" = "adriankarlen";
    "repo" = "textfox";
    "rev" = "d5bfe864c50b17ea62750458e83877a5256aca5b";
    "hash" = "sha256-wGoP8VHBKn2QNaQpyeOn6bx+thccMT5TgWxxeefzxj4=";
  };
  betterfox = pkgs.fetchFromGitHub {
    "owner" = "yokoffing";
    "repo" = "Betterfox";
    "rev" = "3b159ac8fbb3d5921db8ff1763aa51cff12ea1ec";
    "hash" = "sha256-sZEgmCrAm0SnRoFmn8glScII07Kvpa6cYdC6jHHQmMI=";
  };
in {
  imports = [
    ./search.nix
    ./extensions.nix
    ./settings.nix
    ./policies.nix
  ];
  stylix.targets.floorp.enable = false;

  programs.floorp = {
    enable = true;
    nativeMessagingHosts = [ pkgs.tridactyl-native ];

    profiles.zdyant = {
      id = 0;
      isDefault = true;
      name = "zdyant";
      extraConfig = ''
        ${builtins.readFile "${betterfox}/user.js"}
        ${builtins.readFile "${betterfox}/Fastfox.js"}
        ${builtins.readFile "${betterfox}/Peskyfox.js"}
        ${builtins.readFile "${betterfox}/Smoothfox.js"}
        user_pref("shyfox.enable.ext.mono.toolbar.icons", true);
        user_pref("shyfox.enable.ext.mono.context.icons", true);
      '';
      userChrome = builtins.readFile "${textfox}/chrome/userChrome.css";
      userContent = builtins.readFile "${textfox}/chrome/userContent.css";
    };
  };

  home.file."${config.home.homeDirectory}/.floorp/${config.home.username}/chrome/" =
    {
      source = "${textfox}/chrome";
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

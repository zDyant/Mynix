{ pkgs, ... }: {
  programs.floorp.profiles.zdyant.search = {

    force = true;
    default = "ddg";
    engines = {
      google.metaData.alias = "@g";

      "Nix Packages" = {
        urls = [{
          template =
            "https://search.nixos.org/packages?type=packages&query={searchTerms}";
        }];
        icon =
          "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@np" ];
      };

      "Nix Options" = {
        urls = [{
          template =
            "https://search.nixos.org/options?channel=unstable&type=packages&query={searchTerms}";
        }];
        icon =
          "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@no" ];
      };

      "Home-manager Options" = {
        urls = [{
          template =
            "https://home-manager-options.extranix.com/?query={searchTerms}&release=master";
        }];
        definedAliases = [ "@ho" ];
      };

      "Noogle" = {
        urls = [{ template = "https://noogle.dev/{searchTerms}"; }];
        icon =
          "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        definedAliases = [ "@ng" ];
      };

      "Youtube" = {
        urls = [{
          template =
            "https://www.youtube.com/results?search_query={searchTerms}";
        }];
        icon = "https://youtube.com/favicon.ico";
        updateInterval = 24 * 60 * 60 * 1000;
        definedAliases = [ "@yt" ];
      };

      "Github" = {
        urls = [{ template = "https://github.com/search?q={searchTerms}"; }];
        icon = "https://github.com/fluidicon.png";
        updateInterval = 7 * 24 * 60 * 60 * 1000;
        definedAliases = [ "@gh" ];
      };

      "Online-fix" = {
        urls = [{
          template =
            "https://online-fix.me/index.php?do=search&subaction=search&story={searchTerms}";
        }];
        updateInterval = 7 * 24 * 60 * 60 * 1000;
        definedAliases = [ "@ofme" ];
      };

    };
  };

}

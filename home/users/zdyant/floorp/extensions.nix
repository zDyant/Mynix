{ pkgs, ... }: {
  programs.floorp.profiles.zdyant.extensions = {
    force = true;
    packages = with pkgs.nur.repos.rycee.firefox-addons; [
      bitwarden
      sponsorblock
      stylus
      ublock-origin
      refined-github
      localcdn
      clearurls
      privacy-badger
      don-t-fuck-with-paste
      skip-redirect
      tridactyl
      to-google-translate
      istilldontcareaboutcookies
      return-youtube-dislikes
      decentraleyes
      # ambient-light-for-youtube L :C
      tweaks-for-youtube
      # youtube-suite-search-fixer
      violentmonkey
      sidebery
    ];
  };

  programs.floorp.policies = {
    "3rdparty".Extensions = {
      # https://github.com/gorhill/uBlock/blob/master/platform/common/managed_storage.json
      "uBlock0@raymondhill.net" = {
        userSettings = [
          [ "advancedUserEnabled" "true" ]
          [ "autoUpdate" "true" ]
          [ "contextMenuEnabled" "true" ]
          [ "dynamicFilteringEnabled" "true" ]
        ];
        toOverwrite = {
          filters = ''
            reddit.com###right-rail-experience-root > faceplate-tracker
            chatgpt.com##.absolute:has-text("Thanks for trying")
            chatgpt.com##body:style(pointer-events: auto !important)
            youtube.com##div[class^='YtInlinePlayerControlsTopLeftControls']
            youtube.com##div[class^='ytp-paid-content-overlay']
            youtube.com##ytd-rich-section-renderer:has(#dismissible)
            youtube.com##a[href="https://support.google.com/youtube?p=ppp&nohelpkit=1"]
          '';

          # https://github.com/yokoffing/filterlists
          filterLists = [
            "ublock-abuse"
            "ublock-annoyances"
            "ublock-badware"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "ublock-filters"
            "ublock-badware"
            "ublock-privacy"
            "ublock-abuse"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "ublock-badlists"
            "https://raw.githubusercontent.com/liamengland1/miscfilters/master/antipaywall.txt"
            "https://raw.githubusercontent.com/gijsdev/ublock-hide-yt-shorts/master/list.txt"
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/LegitimateURLShortener.txt"
            "https://filters.adtidy.org/extension/ublock/filters/122_optimized.txt"                                                     # Fanboy Annoyances (Optimized)
            "https://filters.adtidy.org/extension/ublock/filters/2_optimized.txt"                                                       # EasyList + Adguard
            "https://filters.adtidy.org/extension/ublock/filters/3_optimized.txt"                                                       # AdGuard Tracking Protection filter (Optimized)
            "https://filters.adtidy.org/extension/ublock/filters/14_optimized.txt"                                                      # AdGuard Annoyances filter (Optimized)
            "https://filters.adtidy.org/extension/ublock/filters/4_optimized.txt"                                                       # AdGuard Social Media filter (Optimized)
            "https://filters.adtidy.org/extension/ublock/filters/118_optimized.txt"                                                     # EasyPrivacy (Optimized)
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/Dandelion%20Sprout's%20Anti-Malware%20List.txt" # Dandelion Sprout's Anti-Malware List
            "https://raw.githubusercontent.com/hagezi/dns-blocklists/refs/heads/main/adblock/spam-tlds-ublock.txt"                      # HaGeZi's The World's Most Abused TLDs
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/BrowseWebsitesWithoutLoggingIn.txt"                        # Browse websites without logging in
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/refs/heads/master/ClearURLs%20for%20uBo/clear_urls_uboified.txt"  # ClearURLs for uBo (unofficial)
          ];
        };
      };
    };

  };
}

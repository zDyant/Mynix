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

          filterLists = [
            "adguard-cookiemonster"
            "adguard-cookies"
            "adguard-mobile-app-banners"
            "adguard-other-annoyances"
            "adguard-popup-overlays"
            "adguard-widgets"
            "dpollock-0"
            "easylist-annoyances"
            "easylist-chat"
            "easylist-newsletters"
            "easylist-notifications"
            "easylist"
            "easyprivacy"
            "fanboy-cookiemonster"
            "plowe-0"
            "ublock-abuse"
            "ublock-annoyances"
            "ublock-badware"
            "ublock-cookies-adguard"
            "ublock-cookies-easylist"
            "ublock-filters"
            "ublock-privacy"
            "ublock-quick-fixes"
            "ublock-unbreak"
            "urlhaus-1"
            "user-filters"
            "easyprivacy"
            "adguard-spyware"
            "adguard-spyware-url"
            "block-lan"
            "easylist"
            "adguard-generic"
            "adguard-mobile"
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
          ];
        };
      };
    };

  };
}

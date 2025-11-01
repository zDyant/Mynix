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

}

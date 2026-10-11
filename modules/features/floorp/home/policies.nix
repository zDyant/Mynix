{...}: {
  programs.floorp.policies = {
    DisableTelemetry = true;
    DisableAppUpdate = true;
    DisableFirefoxAccounts = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;

    OfferToSaveLogins = false;
    OfferToSaveLoginsDefault = false;
    DontCheckDefaultBrowser = true;
    PromptForDownloadLocation = true;

    Preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "browser.tabs.loadInBackground" = true;
      "browser.aboutConfig.showWarning" = false;
      "browser.warnOnQuitShortcut" = true;
      "browser.startup.homepage" = "https://www.cityhop.cafe/";
    };

    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
  };
}

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
    HardwareAcceleration = false;
    PromptForDownloadLocation = true;

    Preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "browser.tabs.loadInBackground" = true;
      "media.ffmpeg.vaapi.enabled" = false;
      "browser.aboutConfig.showWarning" = false;
      "browser.warnOnQuitShortcut" = true;
    };

    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
  };
}

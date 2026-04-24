{ ... }: {
  programs.floorp.policies = {
    DisableTelemetry          = true;
    DisableAppUpdate          = true;
    DisableFirefoxAccounts    = true;
    DisableFirefoxStudies     = true;
    DisablePocket             = true;

    OfferToSaveLogins         = false;
    OfferToSaveLoginsDefault  = false;
    DontCheckDefaultBrowser   = true;
    HardwareAcceleration      = true;
    PromptForDownloadLocation = true;

    Preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "browser.tabs.loadInBackground" = true;
      "media.ffmpeg.vaapi.enabled" = true;
      "browser.aboutConfig.showWarning" = false;
      "browser.warnOnQuitShortcut" = true;
    };

    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };

  };
}

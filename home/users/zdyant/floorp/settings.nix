{ ... }: {
  programs.floorp.profiles.zdyant.settings = {

    # Telemetry
    "browser.ping-centre.telemetry" = false;
    "devtools.onboarding.telemetry.logged" = false;
    "extensions.webcompat-reporter.enabled" = false;
    "browser.urlbar.eventTelemetry.enabled" = false;

    "extensions.autoDisableScopes" = 0;
    "extensions.allowPrivateBrowsingByDefault" = true;

    "middlemouse.paste" = false;
    "browser.toolbars.bookmarks.visibility" = "never";
    "browser.tabs.opentabfor.middleclick" = true;
    "browser.tabs.loadInBackground" = true;
    "browser.aboutConfig.showWarning" = false;
    "browser.tabs.inTitlebar" = 0;
    "browser.newtab.preload" = true;

    # ask for where to download files instead of just putting them wherever
    "browser.download.useDownloadDir" = false;

    # Additional settings textfox need
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "svg.context-properties.content.enabled" = true;
    "layout.css.color-mix.enabled" = true;

    # Disable Form autofill
    # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
    "browser.formfill.enable" = false;
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.available" = "off";
    "extensions.formautofill.creditCards.available" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;

  };
}

{ host, ... }:
{
  programs.floorp.profiles.${host.user.name}.settings = {
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

    # Disable Form autofill
    # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
    "browser.formfill.enable" = false;
    "extensions.formautofill.addresses.enabled" = false;
    "extensions.formautofill.available" = "off";
    "extensions.formautofill.creditCards.available" = false;
    "extensions.formautofill.creditCards.enabled" = false;
    "extensions.formautofill.heuristics.enabled" = false;

    # Linux video/rendering acceleration.
    "media.ffmpeg.vaapi.enabled" = true;
    "media.hardware-video-decoding.force-enabled" = true;
    "layers.gpu-process.enabled" = true;
    "widget.dmabuf.force-enabled" = true;

    # Cache sizes tuned for a 64 GB RAM system.
    "browser.cache.disk.enable" = true;
    "browser.cache.disk.smart_size.enabled" = false;
    "browser.cache.disk.capacity" = 2097152;
    "browser.cache.memory.enable" = true;
    "browser.cache.memory.capacity" = 2097152;
    "image.cache.size" = 268435456;

    # Avoid repeated DNS lookups during long browsing sessions.
    "network.dnsCacheEntries" = 20000;
    "network.dnsCacheExpiration" = 3600;
  };
}

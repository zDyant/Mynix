{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./system24.nix
  ];
  stylix.targets.nixcord.enable = lib.mkDefault false;

  programs.nixcord = lib.mkDefault {
    enable = true;
    discord = {
      vencord.enable = false;
      equicord.enable = true;
      krisp.enable = true;
    };
    config = {
      useQuickCss = true;
      themeLinks = [];
      frameless = true;
      plugins = {
        themeLibrary.enable = true;
        openInApp.enable = true;
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterSettings.enable = true;
        biggerStreamPreview.enable = true;
        clearUrls.enable = true;
        clipsEnhancements.enable = true;
        crashHandler.enable = true;
        disableDeepLinks.enable = true;
        equicordToolbox.enable = true;
        equicordHelper = {
          enable = true;
          noMirroredCamera = true;
        };
        fakeNitro.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        betterForwards.enable = true;
        imageFilename.enable = true;
        gameActivityToggle.enable = true;
        validReply.enable = true;
        voiceButtons.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        webRichPresence.enable = true;
        youtubeAdblock.enable = true;
        webScreenShareFixes.enable = true;
      };
    };
  };
}

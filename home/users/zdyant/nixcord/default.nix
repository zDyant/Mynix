{ lib, inputs, ... }: {
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./system24.nix
    ./krisp.nix
  ];
  stylix.targets.nixcord.enable = false;

  programs.nixcord = {
    enable = true;
    discord = {
      vencord.enable = false;
      equicord.enable = true;
    };
    config = {
      useQuickCss = true;
      themeLinks = [ ];
      frameless = true;
      plugins = {
        themeLibrary.enable = true;
        openInApp.enable = true;
        allCallTimers = {
          enable = true;
          trackSelf = true;
        };
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        anammox.enable = true; # Removes gift/shop/boost buttons..
        animalese.enable = true;
        bannersEverywhere = {
          enable = true;
          animate = true;
        };
        betterCommands.enable = true;
        betterGifAltText.enable = true;
        betterGifPicker.enable = true;
        betterSettings.enable = true;
        biggerStreamPreview.enable = true;
        callTimer.enable = true;
        ClearURLs.enable = true;
        clipsEnhancements.enable = true;
        colorSighted.enable = true;
        crashHandler.enable = true;
        ctrlEnterSend.enable = true;
        disableDeepLinks.enable = true;
        equicordToolbox.enable = true;
        equicordHelper = {
          enable = true;
          noMirroredCamera = true;
          disableCreateDMButton = true;
        };
        fakeNitro.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forwardAnywhere.enable = true;
        ignoreTerms.enable = true;
        imageFilename.enable = true;
        keyboardSounds = {
          enable = true;
          soundPack = "operagx";
        };
        spotifyShareCommands.enable = true;
        spotifyCrack.enable = true;
        spotifyActivityToggle.enable = true;
        validReply.enable = true;
        voiceButtons.enable = true;
        voiceChatDoubleClick.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        webRichPresence.enable = true;
        youtubeAdblock.enable = true;
        webScreenShareFixes.enable = true;
        BlurNSFW.enable = true;
      };
    };
  };
}

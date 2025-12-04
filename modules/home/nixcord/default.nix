{ inputs, ... }: {
  imports = [
    inputs.nixcord.homeModules.nixcord
    ./system24.nix
  ];

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
        USRBG.enable = true;
        allCallTimers = {
          enable = true;
          trackSelf = true;
        };
        alwaysAnimate.enable = true;
        alwaysTrust.enable = true;
        anammox.enable = true;
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
        clearURLs.enable = true;
        clipsEnhancements.enable = true;
        colorSighted.enable = true;
        crashHandler.enable = true;
        ctrlEnterSend.enable = true;
        disableDeepLinks.enable = true;
        equicordHelper = {
          enable = true;
          # disableCreateDmButton = true;
          noMirroredCamera = true;
        };
        equicordToolbox.enable = true;
        fakeNitro.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        followVoiceUser.enable = true;
        forwardAnywhere.enable = true;
        ghosted.enable = true;
        gitHubRepos.enable = true;
        globalBadges.enable = true;
        googleThat = {
          enable = true;
          defaultEngine = "DuckDuckGo";
        };
        ignoreTerms.enable = true;
        imageFilename.enable = true;
        jumpscare.enable = true;
        keyboardSounds = {
          enable = true;
          soundPack = "osu";
        };
        spotifyShareCommands.enable = true;
        spotifyCrack.enable = true;
        spotifyActivityToggle.enable = true;
        userPfp.enable = true;
        validReply.enable = true;
        voiceButtons.enable = true;
        voiceChatDoubleClick.enable = true;
        voiceMessages.enable = true;
        volumeBooster.enable = true;
        webRichPresence.enable = true;
        youtubeAdblock.enable = true;
        webScreenShareFixes.enable = true;
        wigglyText.enable = true;
      };
    };
  };
}

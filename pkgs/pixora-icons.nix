{
  lib,
  pkgs,
  ...
}: let
  whitesur-icon-theme-alt = pkgs.whitesur-icon-theme.override {
    alternativeIcons = true;
  };
in
  pkgs.stdenvNoCC.mkDerivation {
    pname = "pixora-icons";
    version = "2992e37";
    src = pkgs.fetchFromGitHub {
      owner = "tsora1603";
      repo = "pixora-icons";
      rev = "2992e376079dd41f0f05e4312ebbd80c9645407e";
      hash = "sha256-3XrGb2PhUarz4H0jYfBWIB5vOYXOKIlspSIm2+UCyk0=";
    };

    postPatch = ''
      substituteInPlace pixora/index.theme \
        --replace-fail "Inherits=breeze,hicolor" "Inherits=pixelitos-light, WhiteSur,hicolor"
      substituteInPlace pixora-dark/index.theme \
        --replace-fail "Inherits=breeze-dark,hicolor" "Inherits=pixelitos-dark, WhiteSur-dark,hicolor"
    '';

    installPhase = ''
      mkdir -p $out/share/icons
      cp -R pixora pixora-dark $out/share/icons/
    '';

    propagatedUserEnvPkgs = [
      pkgs.pixelitos-icons
      whitesur-icon-theme-alt
      pkgs.hicolor-icon-theme
    ];

    meta = with lib; {
      description = "16-bit pixel art style icons theme for Linux";
      homepage = "https://github.com/tsora1603/pixora-icons";
      platforms = platforms.all;
    };
  }

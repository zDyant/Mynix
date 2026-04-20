{ stdenv, pkgs }:

stdenv.mkDerivation {
  pname = "pixora-icons";
  version = "1.0";
  src = pkgs.fetchFromGitHub {
    owner = "tsora1603";
    repo = "pixora-icons";
    rev = "9e334feb360b2a778ad9f16c999fa3ca516cfbd1";
    hash = "sha256-RkCClbcv+lofjEVvaUGwEXT6M9Sm6tNY8Y5sVKZccWk=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -R pixelitos-dark  $out/share/icons
    cp -R pixora-icons $out/share/icons
  '';
}

{
  lib,
  pkgs,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
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
    cp -R pixora-icons $out/share/icons
  '';

  meta = with lib; {
    description = "16-bit pixel art style icons theme for Linux";
    homepage = "https://github.com/tsora1603/pixora-icons";
    platforms = platforms.all;
  };
}

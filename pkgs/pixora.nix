{ stdenv, fetchFromGitHub, }:

stdenv.mkDerivation {
  pname = "pixora-icon-theme";
  version = "2026-02-17";

  src = fetchFromGitHub {
    owner = "tsora1603";
    repo = "pixora-theme";
    rev = "main";
    sha256 = "sha256-fbWC9EpYA9i7xTfvqRPyD7fx68E8En7DVJIi1QwXUKU=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons
    cp -R pixelitos-light $out/share/icons/
    cp -R pixelitos-dark  $out/share/icons/
    cp -R pixora $out/share/icons/

    runHook postInstall
  '';
}

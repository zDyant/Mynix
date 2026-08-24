{
  lib,
  pkgs,
  ...
}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "pixelitos-icons";
  version = "20260721";
  src = pkgs.fetchFromGitHub {
    owner = "ItsZariep";
    repo = "pixelitos-icon-theme";
    rev = "03a9652d767bbbdcb20b05eb3672cfc3f1434880";
    hash = "sha256-8VHNejri39eyQKhX+7etAXzv3SKOXtbox12nqMrbjJU=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -R pixelitos-dark pixelitos-light $out/share/icons/
  '';

  meta = with lib; {
    description = "Pixel art style icon theme for Linux";
    homepage = "https://github.com/ItsZariep/pixelitos-icon-theme";
    platforms = platforms.all;
  };
}

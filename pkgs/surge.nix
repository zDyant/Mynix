{ stdenv, pkgs }:
stdenv.mkDerivation  rec {
  pname = "Surge";
  version = "0.8.1";
  src = pkgs.fetchurl {
    url = "https://github.com/SurgeDM/Surge/releases/download/v${version}/Surge_${version}_linux_amd64.tar.gz";
    hash = "sha256-mzMZWHY+gJ+YwKK1sEvCR4q2i7NXanhm3v6KIWeDtRw=";
  };
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp surge $out/bin/
    chmod +x $out/bin/surge
  '';
  meta.mainProgram = "surge";
}

{ stdenv, pkgs }:
let
  v = "0.8.1";
in
stdenv.mkDerivation {
  pname = "Surge";
  version = v;
  src = pkgs.fetchurl {
    url = "https://github.com/SurgeDM/Surge/releases/download/v${v}/Surge_${v}_linux_amd64.tar.gz";
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

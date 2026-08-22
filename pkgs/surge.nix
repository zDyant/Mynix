{pkgs, ...}:
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "Surge";
  version = "0.12.0";
  src = pkgs.fetchurl {
    url = "https://github.com/SurgeDM/Surge/releases/download/v${version}/Surge_${version}_linux_amd64.tar.gz";
    hash = "sha256-vrX0mztTScYa6pEmFuFddYDUeFqDPuxBBFZNBRBd3Ys=";
  };
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp surge $out/bin/
    chmod +x $out/bin/surge
  '';
  meta.mainProgram = "surge";
}

{
  appimageTools,
  fetchurl,
  lib,
  makeDesktopItem,
  symlinkJoin,
  ...
}: let
  pname = "optiscaler-client";
  version = "1.0.8";

  src = fetchurl {
    url = "https://github.com/Optiscaler-Client/Optiscaler-Client/releases/download/OptiscalerClient-${version}/OptiscalerClient-${version}-x86_64.AppImage";
    hash = "sha256-mXK3XcQuVzOfNfGhlaHiACv/b8QCOT5d98Ip6D4xPSo=";
  };
  wrapped = appimageTools.wrapType2 {
    inherit pname version src;

    extraPkgs = pkgs:
      with pkgs; [
        findutils
        gnugrep
        icu
        pciutils
        procps
        util-linux
      ];

    passthru = {inherit src;};
  };
in
  symlinkJoin {
    name = "${pname}-${version}";
    paths = [
      wrapped
      (makeDesktopItem {
        name = pname;
        desktopName = "OptiScaler Client";
        genericName = "OptiScaler Manager";
        comment = "Modern manager for OptiScaler";
        exec = "${wrapped}/bin/${pname} %U";
        icon = "applications-games";
        terminal = false;
        categories = ["Game" "Utility"];
      })
    ];
    passthru = {inherit src;};
    meta = with lib; {
      description = "Modern manager for OptiScaler";
      homepage = "https://github.com/Optiscaler-Client/OptiScaler-Client";
      license = licenses.gpl3Plus;
      platforms = ["x86_64-linux"];
      mainProgram = pname;
      sourceProvenance = with sourceTypes; [binaryNativeCode];
    };
  }

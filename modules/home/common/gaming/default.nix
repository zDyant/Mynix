{
  lib,
  pkgs,
  ...
}: {
  imports = lib.fs.scanPaths ./.;

  home.packages = with pkgs; [
    protonup-qt
    nur.repos.uriotv.optiscaler-client
  ];
}

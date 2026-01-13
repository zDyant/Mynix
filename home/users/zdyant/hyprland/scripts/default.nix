{ pkgs, ... }:
let

  volume-control = pkgs.writeScriptBin "volume-control" (builtins.readFile ./volume_control.sh);
  media-control = pkgs.writeScriptBin "media-control" (builtins.readFile ./media_control.sh);
in {

  home.packages = [
    volume-control
    media-control
  ];
}

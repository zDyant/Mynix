{ pkgs, ... }:
let

  wallpaper-select = pkgs.writeScriptBin "wallpaper-select" (builtins.readFile ./wallpaperSelect.sh);
  volume-control = pkgs.writeScriptBin "volume-control" (builtins.readFile ./volume_control.sh);
  media-control = pkgs.writeScriptBin "media-control" (builtins.readFile ./media_control.sh);
  clip-manager = pkgs.writeScriptBin "clip-manager" (builtins.readFile ./clipManager.sh);
in {

  home.packages = with pkgs; [
    wallpaper-select
    volume-control
    media-control
    clip-manager
  ];
}

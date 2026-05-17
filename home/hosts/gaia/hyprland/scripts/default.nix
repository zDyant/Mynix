{ pkgs, ... }:
let
  volume-control = pkgs.writeScriptBin "volume-control"
    (builtins.readFile ./volume_control.sh);
in { home.packages = [ volume-control ]; }

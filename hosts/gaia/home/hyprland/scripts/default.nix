{pkgs, ...}: let
  volume-control = pkgs.writeShellApplication {
    name = "volume-control";
    runtimeInputs = [pkgs.pamixer];
    text = builtins.readFile ./volume_control.sh;
  };
in {home.packages = [volume-control];}

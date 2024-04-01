{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = ./themes/nova-dark.rasi;
    plugins = [ pkgs.rofi-calc ];
  };

}

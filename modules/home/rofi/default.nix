{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = ./themes/nova-dark.rasi;
    plugins = [ 
      (pkgs.rofi-calc.override {
        rofi-unwrapped = pkgs.rofi-wayland-unwrapped;
      })
    ];
  };

}

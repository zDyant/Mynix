{ pkgs, ... }:
{
  programs.bat = {
    enable = true;

    # config = {
    #   theme = "1337";
    # };

    themes = let
      catppuccin = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "b19bea35a85a32294ac4732cad5b0dc6495bed32";
        sha256 = "sha256-POoW2sEM6jiymbb+W/9DKIjDM1Buu1HAmrNP0yC2JPg=";
      };
    in {
      catppuccin-frappe.src     = "${catppuccin}/themes/Catppuccin Frappe.tmTheme";
      catppuccin-latte.src      = "${catppuccin}/themes/Catppuccin Latte.tmTheme";
      catppuccin-macchiato.src  = "${catppuccin}/themes/Catppuccin Macchiato.tmTheme";
      catppuccin-mocha.src      = "${catppuccin}/themes/Catppuccin Mocha.tmTheme";

    };
  };
}

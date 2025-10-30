{ pkgs, ... }:
{
  stylix = {
    enable = true;

    targets = {
      rofi.enable = false;

    };

    iconTheme = {
      enable = true;
      package = pkgs.reversal-icon-theme;
      dark = "Reversal";
    };

  };

}

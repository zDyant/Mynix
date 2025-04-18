{ pkgs, ... }:
{
  stylix = {
    enable = true;

    targets = {
      rofi.enable = false;
      spicetify.enable = false;
    };

    iconTheme = {
      enable = true;
      package = pkgs.reversal-icon-theme;
      dark = "Reversal";
    };

  };

}

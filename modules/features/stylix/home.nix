{
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    targets = {
      kde.enable = false;
      rofi.enable = false;
      qt = {
        enable = true;
        platform = "qtct";
      };
    };

    icons = lib.mkForce {
      enable = true;
      package = pkgs.reversal-icon-theme;
      dark = "Reversal-dark";
    };
  };
}

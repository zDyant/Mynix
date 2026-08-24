{
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    targets = {
      kde.enable = false;
      qt = {
        enable = true;
        platform = "qtct";
      };
    };

    icons = lib.mkForce {
      enable = true;
      package = pkgs.pixora-icons;
      dark = "pixora-dark";
    };
  };

  home.packages = [
    pkgs.pixelitos-icons
    (pkgs.whitesur-icon-theme.override {
      alternativeIcons = true;
    })
  ];
}

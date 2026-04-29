{
  lib,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;

    targets = {
      qt = {
        enable = true;
        platform = "qtct";
      };
    };

    icons = lib.mkForce {
      enable = true;
      package = pkgs.pixora-icons;
      dark = "pixora-icons";
    };
  };
}

{
  lib,
  pkgs,
  ...
}: {
  stylix = lib.mkForce {
    enable = true;

    targets = {
      qt = {
        enable = true;
        platform = "qtct";
      };
    };

    icons = {
      enable = true;
      package = pkgs.pixora-icons;
      dark = "pixora-icons";
    };
  };
}

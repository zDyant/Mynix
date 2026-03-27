{ pkgs, ... }: {
  stylix = {
    enable = true;

    targets = {
      qt = {
        enable = true;
        platform = "qtct";
      };

    };

    icons = {
      enable = true;
      package = pkgs.pixora-icon-theme;
      dark  = "pixora";
    };

  };

}

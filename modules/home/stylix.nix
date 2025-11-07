{ pkgs, ... }: {
  stylix = {
    enable = true;

    targets = {
      qt = {
        enable = true;
        platform = "qtct";
      };

    };

    iconTheme = {
      enable = true;
      package = pkgs.reversal-icon-theme;
      dark = "Reversal";
    };

  };

}

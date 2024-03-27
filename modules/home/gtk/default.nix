{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerdfonts
    (nerdfonts.override {
      fonts = [
      "JetBrainsMono"
      ];
    })
    gradience
    bibata-cursors
    whitesur-icon-theme
    adw-gtk3
  ];

  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };

    iconTheme = {
      name = "WhiteSur";
      package = pkgs.whitesur-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };

  };

  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 16;
  };

  home.sessionVariables = { GTK_THEME = "adw-gtk3"; };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}


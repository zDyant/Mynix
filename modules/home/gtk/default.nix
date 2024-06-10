{ config, pkgs, ... }:
{
  gtk = {
    enable = true;

    theme = {
      name = "Orchis-Dark-Dracula";
      package = pkgs.orchis-theme.override {
        tweaks = [ "dracula" ];
      };
    };

    font = {
      name = "Geist Mono";
      package = pkgs.geist-font;
      size = 11;
    };

    iconTheme = {
      name = "Reversal";
      package = pkgs.reversal-icon-theme;
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

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  # Tweak mf libadwaita
  xdg.configFile = {
  "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
  "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
  "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}


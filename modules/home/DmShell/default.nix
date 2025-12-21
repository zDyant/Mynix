{ inputs, config, ... }:
let
  colorScheme = {
    dark = with config.lib.stylix.colors.withHashtag; {
      name = "Stylix Dark";
      primary =                                base0D; # Accent bg
      primaryText =                            base00; # Accent text
      primaryContainer =                       base0C; # ?
      secondary =                              base0E; # ?
      surface =                                base00; # Bg of the buttons on the bar
      surfaceText =                            base05; # Main text
      surfaceVariant =                         base02; # Inactive buttons on settings
      surfaceVariantText =                     base0C; # text
      surfaceTint =                            base0F; # ?
      background =                             base00; # ?
      backgroundText =                         base05; # ?
      outline =                                base03; # Switch and bg progress bar
      surfaceContainer =                       base02; # Main bg
      surfaceContainerHigh =                   base00; # Cards
      error =                                  base08;
      warning =                                base0A;
      info =                                   base0C;
    };


    light = with config.lib.stylix.colors.withHashtag; {
      name = "Stylix generated light theme";
      primary =                                base0D;
      primaryText =                            base07;
      primaryContainer =                       base0C;
      secondary =                              base0E;
      surface =                                base06;
      surfaceText =                            base01;
      surfaceVariant =                         base07;
      surfaceVariantText =                     base02;
      surfaceTint =                            base0D;
      background =                             base07;
      backgroundText =                         base00;
      outline =                                base04;
      surfaceContainer =                       base06;
      surfaceContainerHigh =                   base05;
      error =                                  base08;
      warning =                                base0A;
      info =                                   base0C;
    };
  };
in {
  imports = [ inputs.dms.homeModules.dankMaterialShell.default ];
  programs.dankMaterialShell = {
    enable = true;
    systemd.enable = true;
    systemd.restartIfChanged = true;

    # default.settings = lib.mkMerge [{
    #   currentThemeName = "custom";
    #   customThemeFile = pkgs.writeText "stylix.json" (builtins.toJSON colorScheme);
    # }];
  };

  xdg.configFile."DankMaterialShell/stylix.json".text = builtins.toJSON colorScheme;
}

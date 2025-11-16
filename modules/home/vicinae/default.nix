{ inputs, config, pkgs, ... }: {
  imports = [ inputs.vicinae.homeManagerModules.default ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [ "vicinae server" ];
    bind = [
      "$mod, $mod_L, exec, vicinae toggle"
      "$mod, A, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
    ];
  };

  services.vicinae = {
    enable = true;
    useLayerShell = false;

    settings = {
      faviconService = "twenty";
      popToRootOnClose = true;
      rootSearch.searchFiles = false;

      theme = {
        name = "stylix";
        iconTheme = config.stylix.iconTheme.dark;
      };

      font = {
        normal = "MapleMono NF";
        size = 12;
      };

      window = {
        csd = true;
        opacity = 1;
        rounding = 0;
      };
    };

    extensions = let
      mkExt = name:
        pkgs.runCommand "vicinae-ext-${name}" { } ''
          mkdir -p $out
          cp -r ${inputs.vicinae-extensions}/extensions/${name}/* $out/
        '';
    in [
      (mkExt "nix")
    ];
  };

  home.file.".local/share/vicinae/themes/stylix.toml".text =
    with config.lib.stylix.colors.withHashtag; ''
      [meta]
      version = 1
      name = "Stylix"
      description = "Stylix dynamic theme"
      variant = "dark"
      inherits = "vicinae-dark"

      [colors.core]
      accent               = "${base0B}"
      accent_foreground    = "${base00}"
      background           = "${base00}"
      foreground           = "${base05}"
      secondary_background = "${base01}"
      border               = "${base02}"

      [colors.accents]
      blue                 = "${base0B}"
      green                = "${base0C}"
      magenta              = "${base0D}"
      orange               = "${base0A}"
      purple               = "${base0D}"
      red                  = "${base08}"
      yellow               = "${base0E}"
      cyan                 = "${base0C}"

      [colors.text]
      default              = "${base05}"
      muted                = "${base04}"
      danger               = "${base08}"
      success              = "${base0B}"
      placeholder          = "${base03}"
      selection            = { background = "${base0D}", foreground = "${base00}" }

      [colors.text.links]
      default              = "${base0D}"
      visited              = "${base0F}"

      [colors.input]
      border               = "${base02}"
      border_focus         = "${base0D}"
      border_error         = "${base08}"

      [colors.button.primary]
      background           = "${base02}"
      foreground           = "${base05}"
      hover                = { background = "${base03}" }
      focus                = { outline    = "${base0D}" }

      [colors.list.item.hover]
      background           = "${base02}"
      foreground           = "${base05}"

      [colors.list.item.selection]
      background           = { name = "${base0D}", opacity = 0.1 }
      foreground           = "${base0D}"
      secondary_background = "${base02}"
      secondary_foreground = "${base05}"

      [colors.grid.item]
      background           = "${base01}"
      hover                = { outline    = "${base05}" }
      selection            = { outline    = "${base0D}" }

      [colors.scrollbars]
      background           = "${base02}"

      [colors.main_window]
      border               = "${base0A}"

      [colors.settings_window]
      border               = "${base02}"

      [colors.loading]
      bar                  = "${base05}"
      spinner              = "${base05}"
    '';
}

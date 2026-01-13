{ inputs, config, pkgs, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "$mod, A, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
      "$mod, $mod_L, exec, vicinae toggle"
    ];
  };

  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    systemd.autoStart = true;
    useLayerShell = true;

    settings = {
      faviconService = "twenty";
      popToRootOnClose = true;
      rootSearch.searchFiles = false;

      font = {
        normal = "${config.stylix.fonts.monospace.name}";
        size = 12;
      };

      window = {
        csd = true;
        rounding = 0;
      };
    };

    extensions = let
      mkExt = name:
        pkgs.runCommand "vicinae-ext-${name}" { } ''
          mkdir -p $out
          cp -r ${inputs.vicinae-extensions}/extensions/${name}/* $out/
        '';
    in [ (mkExt "nix") ];
  };

}

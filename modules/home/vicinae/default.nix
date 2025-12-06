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

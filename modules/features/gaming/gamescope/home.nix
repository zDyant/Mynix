# https://github.com/TophC7/dot.nix/blob/7525be62c9677767bdcf2fbf28774317b12a107a/modules/features/gaming/home/gamescope.nix#L23
{
  osConfig,
  lib,
  inputs,
  ...
}: let
  baseOptions = {
    backend = "wayland";
    fullscreen = false;
  };
  baseEnv = {
    WINEDLLOVERRIDES = "dinput8,dxgi,dsound,version=n,b";
  };
in {
  imports = [inputs.wayscope.homeManagerModules.wayscope];

  programs.wayscope = {
    enable = true;

    profiles = {
      default = {
        useWSI = true;
        options = baseOptions;
      };

      # WARN: steam does not open in normal "desktop mode" with gamescope
      steam = {
        useWSI = true;
        options =
          baseOptions
          // {
            steam = true;
          };
        environment =
          baseEnv
          // {
            STEAM_FORCE_DESKTOPUI_SCALING = "1";
          };
      };
    };

    wrappers = {
      steam = {
        enable = true;
        profile = "steam";
        command = lib.getExe osConfig.programs.steam.package;
      };

      heroic = {
        enable = true;
        profile = "default";
        inherit (osConfig.play.heroic) package;
      };
    };
  };
}

{ config, lib, pkgs, ... }:
let
  hyprshot = lib.getExe pkgs.hyprshot;
  wf-recorder = lib.getExe pkgs.wf-recorder;
  mkMenu = menu:
    let
      configFile = pkgs.writeText "config.yaml" (lib.generators.toYAML { } {
        anchor = "bottom";
        margin_bottom = 8;

        font = config.stylix.fonts.monospace.name;
        color = config.lib.stylix.colors.withHashtag.base05;
        background = config.lib.stylix.colors.withHashtag.base00;
        border = config.lib.stylix.colors.withHashtag.base0A;
        border_width = 1;
        corner_r = 0;
        padding = 16;

        inherit menu;
      });
    in pkgs.writeShellScriptBin "my-menu" ''
      pkill ${lib.getExe pkgs.wlr-which-key} ; exec ${
        lib.getExe pkgs.wlr-which-key
      } ${configFile}
    '';
  menuBind = entries: "$mod, D, exec, ${lib.getExe (mkMenu entries)}";

in {
  wayland.windowManager.hyprland.settings.bind = [
    (menuBind [
      # Apps
      {
        key = "e";
        desc = "Cosmic Files";
        cmd = lib.getExe pkgs.cosmic-files;
      }

      # Recording
      {
        key = "r";
        desc = "Record";
        submenu = let timestamp = "$(date +%Y-%m-%d_%H-%M-%S)";
        in [
          {
            key = "f";
            desc = "Record Fullscreen";
            cmd =
              "${wf-recorder} -f ~/Videos/${timestamp}.mp4 & notify-send 'Started recording'";
          }
          {
            key = "r";
            desc = "Record Region";
            cmd = "${wf-recorder} -g \"$(${
                lib.getExe pkgs.slurp
              })\" -f ~/Videos/${timestamp}.mp4 & notify-send 'Started recording'";
          }
          {
            key = "q";
            desc = "Stop Recording";
            cmd = "${
                lib.getExe pkgs.killall
              } -s SIGINT ${wf-recorder} && notify-send 'Stopped recording'";
          }
        ];
      }

      # Screenshot
      {
        key = "s";
        desc = "Screenshot";
        submenu = [
          {
            key = "r";
            desc = "Capture Region";
            cmd = "${hyprshot} -m region";
          }
          {
            key = "c";
            desc = "[] Capture Region";
            cmd = "${hyprshot} -m region --clipboard-only";
          }
          {
            key = "f";
            desc = "Capture Region Freeze";
            cmd = "${hyprshot} -z -m region";
          }
          {
            key = "z";
            desc = "[] Capture Region Freeze";
            cmd = "${hyprshot} -z -m region --clipboard-only";
          }
        ];
      }

      # Power
      {
        key = "p";
        desc = "Power";
        submenu = [
          {
            key = "s";
            desc = "Sleep";
            cmd = "systemctl suspend";
          }
          {
            key = "r";
            desc = "Reboot";
            cmd = "reboot";
          }
          {
            key = "o";
            desc = "Power Off";
            cmd = "poweroff";
          }
          {
            key = "g";
            desc = "Reboot into Grub";
            cmd = "sudo grub-reboot && sudo reboot";
          }
        ];
      }

    ])
  ];
}


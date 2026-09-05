{
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../_helper.nix {inherit lib;})
    bind
    exec
    ;
  dotsPath = "/repos/dots";

  terminal = "${lib.getExe pkgs.kitty} --single-instance";
  shell = "${lib.getExe pkgs.zsh} -c";
  playerctl = "${lib.getExe pkgs.playerctl} -p spotify";

  yazi = lib.getExe pkgs.yazi;
  rishot = lib.getExe pkgs.rishot;

  dms = "dms ipc";
in {
  wayland.windowManager.hyprland.settings.bind = [
    # Sound control
    (bind "SUPER +  V      " (exec "volume-control --inc")) # volume up
    (bind "SUPER +  Z      " (exec "volume-control --dec")) # volume down
    (bind "SUPER +  SPACE  " (exec "${playerctl} play-pause"))
    (bind "SUPER +  C      " (exec "${playerctl} next"))
    (bind "SUPER +  X      " (exec "${playerctl} previous"))

    # Launchers
    (bind "SUPER +  T      " (exec terminal))
    (bind "SUPER + E" (exec "${terminal} ${shell} ${yazi}"))
    (bind "SUPER +  RETURN " (exec "${terminal} ${shell} 'cd ${dotsPath}; nvim +terminal'"))

    (bind "SUPER +  S       " (exec rishot))

    # DmsShell
    (bind "SUPER +  A"      (exec "${dms} clipboard toggle"))
    (bind "SUPER + Super_L" (exec "${dms} launcher toggle"))
    (bind "SUPER +  W"      (exec "${dms} hypr toggleOverview"))
  ];
}

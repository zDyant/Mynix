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
in {
  wayland.windowManager.hyprland.settings.bind = [
    # Sound control
    (bind "SUPER +  V      " (exec "volume-control --inc")) # volume up
    (bind "SUPER +  Z      " (exec "volume-control --dec")) # volume down
    (bind "SUPER +  SPACE  " (exec "${playerctl} play-pause"))
    (bind "SUPER +  C      " (exec "${playerctl} next"))
    (bind "SUPER +  X      " (exec "${playerctl} previous"))

    # Launchers
    (bind "SUPER +  T      " (exec "${terminal}")) # Launch terminal
    (bind "SUPER +  E      " (exec "${terminal} ${shell} ${lib.getExe pkgs.yazi}")) # File manager
    (bind "SUPER +  RETURN " (exec "${terminal} ${shell} 'cd ${dotsPath}; nvim +terminal'"))

    (bind "SUPER +  S       " (exec rishot))

    # DmsShell
    (bind "SUPER +  A        " (exec "dms ipc clipboard toggle        "))
    (bind "SUPER+ Super_L" (exec "dms ipc launcher toggle"))
    (bind "SUPER +  W        " (exec "dms ipc call hypr toggleOverview"))
  ];
}

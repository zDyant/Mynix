{
  lib,
  pkgs,
  ...
}: let
  inherit
    (import ../_helper.nix {inherit lib;})
    execHook
    lua
    func
    mkArgs
    ;
  on = event: body: mkArgs [event (lua (func body))];
  play = file:
    execHook "${lib.getExe' pkgs.pipewire "pw-play"} --volume 0.2 ${file}";
in {
  wayland.windowManager.hyprland.settings.on = let
    attention = ./item_appear_09.wav;
    close = ./click_2.wav;
    click = ./click.wav;
    move = ./item_appear_06.wav;
  in [
    (on "window.open_early" (play move))
    (on "window.close" (play close))
    (on "window.active" (play click))
    (on "window.move_to_workspace" (play attention))
  ];
}

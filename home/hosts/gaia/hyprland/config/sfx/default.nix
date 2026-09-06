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
    item = ./item_appear_09.wav;
    click2 = ./click_07.wav;
    click = ./click.wav;
    item2 = ./item_appear_06.wav;
  in [
    (on "window.open_early" (play item2))
    (on "window.close" (play click2))
    (on "window.active" (play click))
    (on "window.move_to_workspace" (play item))
  ];
}

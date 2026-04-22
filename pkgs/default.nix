# https://github.com/TophC7/mix.nix/blob/main/packages/default.nix
{
  lib,
  pkgs,
}:
lib.fs.importAttrs ./. {inherit lib pkgs;}

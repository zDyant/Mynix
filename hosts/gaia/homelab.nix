{
  lib,
  flakeRoot,
  ...
}: {
  imports = map (lib.fs.relativeTo flakeRoot) [
    "modules/homelab"
  ];

  homelab.enable = true;
}

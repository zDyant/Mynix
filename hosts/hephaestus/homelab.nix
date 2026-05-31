{
  lib,
  flakeRoot,
  ...
}: {
  imports = map (lib.fs.relativeTo flakeRoot) [
    "modules/homelab"
  ];

  homelab = {
    enable = true;
    domain = "zdyant.com";

    services = {
      glance.enable = true;
      openmonetis.enable = true;
    };
  };
}

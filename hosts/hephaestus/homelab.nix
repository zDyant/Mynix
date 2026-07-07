{
  lib,
  flakeRoot,
  host,
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
      kutt.enable = true;
      karakeep.enable = true;
      restic = {
        enable = true;
        repository = "rclone:filen-remote:restic/hephaestus";
        passwordFile = "/home/${host.user.name}/.config/restic/filen-remote-password";
        rcloneConfigFile = "/home/${host.user.name}/.config/rclone/rclone.conf";
      };
    };
  };
}

{
  lib,
  host,
  pkgs,
  ...
}: {
  homelab = {
    enable = true;
    domain = "zdyant.com";

    services = {
      hister = {
        enable = true;
        environmentFile = "/var/lib/hister/secrets.env";
        allowPatterns = [
          "^https?://github\\.com(/|$|\\?)"
          "^https?://(www\\.|old\\.)?reddit\\.com/r/(nixos|hyprland)(/|$|\\?)"
        ];
      };
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

  system.activationScripts.histerAccessToken = lib.stringAfter ["users"] ''
    token_file=/var/lib/hister/secrets.env
    ${pkgs.coreutils}/bin/install -d -m 0750 -o hister -g hister /var/lib/hister
    if [ ! -s "$token_file" ]; then
      umask 077
      printf 'HISTER__APP__ACCESS_TOKEN=%s\n' "$(${pkgs.openssl}/bin/openssl rand -hex 32)" > "$token_file"
    fi
  '';
}

{
  lib,
  config,
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
      openmonetis = {
        enable = true;
        environmentFile = "/var/lib/openmonetis/app.env";
        postgresEnvironmentFile = "/var/lib/openmonetis/postgres.env";
      };
      kutt = {
        enable = true;
        environmentFile = "/var/lib/kutt/secrets.env";
      };
      karakeep.enable = true;
      rss = let
        steamGames = {
          "427410" = "Abiotic Factor";
          "3110760" = "Alabaster Dawn";
          "2529790" = "GRIME II";
          "2024600" = "Into the Unwell";
          "2719590" = "Light No Fire";
          "1169040" = "Necesse";
          "1371980" = "No rest for the wicked";
          "2961930" = "TemTem: Pioneers";
          "2376260" = "Mariachi Legends";
          "2843060" = "Into the Wind";
          "3910680" = "Inari";
          "1203170" = "Darksiders 4";
          "2090210" = "Threads of Time";
          "1739080" = "Sword Hero";
          "2146290" = "The Big Catch";
          "3724710" = "Gunstoppable";
          "3808690" = "Pathogenic";
          "2445690" = "Lost Castle 2";
        };
        mkSteamFeed = appId: "https://store.steampowered.com/feeds/news/app/${appId}/";
      in {
        enable = true;
        labels =
          lib.mapAttrs' (
            appId: game: lib.nameValuePair "https://store.steampowered.com/news/app/${appId}/" game
          )
          steamGames;
        groups = {
          linux = [
            "https://nixos.org/blog/feed.xml"
            "https://feed.itsfoss.com"
            "https://omglinux.com/feed/"
            "https://wololo.net/feed/"
          ];
          github = let
            mkGithubFeed = repo: "https://github.com/${repo}/releases.atom";
          in (map mkGithubFeed [
            "hyprwm/hyprland"
            "karakeep-app/karakeep"
            "memstechtips/Winhance"
            "VERT-sh/vertd"
            "canvas-commons/canvas-commons"
            "AvengeMedia/DankMaterialShell"
            "felipegcoutinho/openmonetis"
            "ilya-zlobintsev/LACT"
          ]);
          games = lib.mapAttrsToList (appId: _: mkSteamFeed appId) steamGames;
        };
      };
      restic = {
        enable = true;
        repository = "rclone:filen-remote:restic/hephaestus";
        passwordFile = "/home/${host.user.name}/.config/restic/filen-remote-password";
        rcloneConfigFile = "/home/${host.user.name}/.config/rclone/rclone.conf";
      };
    };
  };

  system.activationScripts.histerAccessToken = lib.mkIf (config.homelab.enable && config.homelab.services.hister.enable) (lib.stringAfter ["users"] ''
    token_file=/var/lib/hister/secrets.env
    ${pkgs.coreutils}/bin/install -d -m 0750 -o hister -g hister /var/lib/hister
    if [ ! -s "$token_file" ]; then
      umask 077
      printf 'HISTER__APP__ACCESS_TOKEN=%s\n' "$(${pkgs.openssl}/bin/openssl rand -hex 32)" > "$token_file"
    fi
  '');
}

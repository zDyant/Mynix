{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services."glance";

  toServiceName = title: "${lib.toLower title}";
  mkSite = { title, icon, fixedPort ? null, extra ? { } }:
  let
    isEnabled = homelab.services.${toServiceName title}.enable;
  in 
    if !isEnabled then
      null
    else
    {
      inherit title;
      url = if fixedPort != null then
        "http://localhost:${toString fixedPort}"
      else
        "http://localhost:${
          toString homelab.services.${toServiceName title}.port
        }";
      icon = "sh:${icon}";
    } // extra;
in {
  options.homelab.services."glance" = {
    enable = lib.mkEnableOption "Custom Glance configuration";
    port = lib.mkOption {
      type = lib.types.port;
      default = 45556;
      description = "Glance bind address";
      example = 8080;
    };
  };

  config = lib.mkIf cfg.enable {
    services.glance = {
      enable = true;
      openFirewall = true;

      settings = {
        server = { port = cfg.port; };

        pages = [{
          name = "Home";
          columns = [

            { # Left column
              size = "small";
              widgets = [
                { type = "calendar"; }
                {
                  type = "weather";
                  location = "Sao Paulo, Brazil";
                }
                { type = "server-stats"; }
                {
                  type = "monitor";
                  cache = "5m";
                  title = "Services";
                  style = "compact";
                  sites             = [
                    (mkSite { title = "Qbittorrent"; icon  = "qbittorrent"; })
                    (mkSite { title = "Prowlarr"; icon     = "prowlarr"; })
                    (mkSite { title = "Flaresolverr"; icon = "flaresolverr"; })
                    (mkSite { title = "Radarr"; icon       = "radarr"; })
                    (mkSite { title = "Sonarr"; icon       = "sonarr"; })
                    (mkSite { title = "Plex"; icon         = "plex"; fixedPort = 32400; extra = { alt-status-codes = [ 401 ]; }; })
                    (mkSite { title = "Ollama"; icon       = "ollama"; })
                    (mkSite { title = "Open-webui"; icon   = "open-webui"; })
                    (mkSite { title = "Kutt";       icon   = "kutt"; })
                  ];
                }

              ];
            }

            { # Main column
              size = "full";
              widgets = [
                {
                  type = "rss";
                  limit = 10;
                  collapse-after = 6;
                  cache = "3h";
                  feeds = [
                    { url = "https://9to5linux.com/feed"; }
                    { url = "https://pointieststick.com/feed/"; }
                    { url = "https://diolinux.com.br/feed"; }
                    { url = "https://news.nononsenseapps.com/index.atom"; }
                    { url = "https://www.gamingonlinux.com/article_rss.php"; }
                    { url = "https://news.itsfoss.com/latest/rss/"; }
                    { url = "https://linuxgamingcentral.org/posts/index.xml"; }
                    { url = "https://www.omglinux.com/feed/"; }
                    { url = "https://www.phoronix.com/rss.php"; }
                    { url = "https://tuxphones.com/rss/"; }
                    { url = "https://wololo.net/feed/"; }
                  ];
                }
                {
                  type = "videos";
                  style = "grid-cards";
                  collapse-after-row = 3;
                  channels = [
                    "UCsnGwSIHyoYN0kiINAGUKxg" # Wolfgang's Channel
                    "UChRFo9vcnuwvcz0DWTEaBNw" # Vex
                    "UC7YOGHUfC1Tb6E4pudI9STA" # Mental outlaw
                    "UCQPaSBaTONuIcSzb-CE3dyQ" # TvPH
                  ];
                }
              ];
            }

            { # Right column
              size = "small";
              widgets = [
                {
                  type = "bookmarks";
                  groups = [
                    {
                      title = "Piracy";
                      links = [
                        {
                          title = "FMHY";
                          url = "https://fmhy.net/";
                        }
                        {

                          title = "Megathread";
                          url = "https://rentry.co/megathread";
                        }
                        {
                          title = "Pirated Games Mega Thread";
                          url = "https://rentry.org/pgames";
                        }
                        {
                          title = "Wiki Index";
                          url = "https://wiki-index.pages.dev/";
                        }
                        {
                          title = "r/ROMs Megathread";
                          url = "https://r-roms.github.io/";
                        }
                        {
                          title = "Media Savyy";
                          url = "https://mediasavvy.pages.dev/";
                        }
                        {
                          title = "Open Together";
                          url = "https://opentogethertube.com/";
                        }
                      ];
                    }

                    {
                      title = "Utils";
                      links = [
                        {
                          title = "Mazanoke - Image optimizer in your browser";
                          url = "https://mazanoke.com/ ";
                        }
                        {
                          title = "Zero-Share - P2P file sharing";
                          url = "https://github.com/ntsd/zero-share";
                        }
                        {
                          title = "Quick Reference";
                          url = "https://quickref.me/";
                        }
                        {
                          title = "Devhints";
                          url = "https://devhints.io/";
                        }
                        {
                          title = "Drawnix";
                          url = "https://drawnix.com/";
                        }
                      ];
                    }
                  ];
                }
                {
                  type = "releases";
                  cache = "1d";
                  repositories =
                    [
                      "rust-lang/rust"
                      "glanceapp/glance"
                      "hyprwm/hyprland"
                      "9001/copyparty"
                    ];
                }
              ];
            }

          ];

        }];

      };
    };
  };
}

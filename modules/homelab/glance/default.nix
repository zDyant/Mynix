{ config, lib, ... }:
let
  homelab = config.homelab;
  cfg = homelab.services."glance";

  toServiceName = title: "${lib.toLower title}";
  mkSite = { title, icon, fixedPort ? null, extra ? { } }:
    let
      serviceName = toServiceName title;
      hasService = builtins.hasAttr serviceName homelab.services;
      isEnabled = hasService && homelab.services.${serviceName}.enable;
    in if !isEnabled then
      null
    else
      {
        inherit title;
        url = if fixedPort != null then
          "http://localhost:${toString fixedPort}"
        else
          "http://localhost:${
            toString homelab.services.${serviceName}.port
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
                  sites = [
                    (mkSite {
                      title = "Ollama";
                      icon = "ollama";
                    })
                    (mkSite {
                      title = "Kutt";
                      icon = "kutt";
                    })
                    (mkSite {
                      title = "Openmonetis";
                      icon = "openmonetis";
                    })
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
                  collapse-after = 5;
                  cache = "3h";
                  feeds = [
                    { url = "https://9to5linux.com/feed"; }
                    { url = "https://gamingonlinux.com/rss"; }
                    { url = "https://feed.itsfoss.com"; }
                    { url = "https://omglinux.com/feed/"; }
                    { url = "https://phoronix.com/rss.php"; }
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

                    {
                      title = "Anki";
                      links = [
                        {
                          title = "Cherry's Ankiweb";
                          url = "https://ankiweb.net/shared/by-author/857020437";
                        }
                        {
                          title = "Cherry's Kofi";
                          url = "https://ko-fi.com/cherry_berry/shop/";
                        }
                        {
                          title = "Kelciour's notion";
                          url = "https://kelciour.notion.site/Home-14b745ea2520800cbd92ed43718202b6#29d745ea252080e5a446fd84d249fed1";
                        }
                        {
                          title = "Kelciour's ankiweb";
                          url = "https://ankiweb.net/shared/by-author/201620050";
                        }
                        {
                          title = "Kelciour's ankiweb 2";
                          url = "https://ankiweb.net/shared/by-author/273874825";
                        }
                      ];
                    }

                  ];
                }
                {
                  type = "releases";
                  cache = "7d";
                  repositories = [
                    "glanceapp/glance"
                    "hyprwm/hyprland"
                    "quickshell-mirror/quickshell"
                    "motion-canvas/motion-canvas"
                    "felipegcoutinho/openmonetis"
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

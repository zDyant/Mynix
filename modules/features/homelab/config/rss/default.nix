{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config) homelab;
  cfg = homelab.services.rss;
  funnelConfig = (pkgs.formats.yaml {}).generate "rss-funnel.yaml" {
    endpoints =
      lib.mapAttrsToList (name: feeds: {
        path = "/${name}";
        source = {
          format = "atom";
          title = name;
          link =
            if homelab.domain != null
            then "https://rss.${homelab.domain}/${name}"
            else "http://localhost:${toString cfg.port}/${name}";
        };
        filters = [
          {
            merge = {
              source = lib.unique feeds;
              parallelism = 8;
              client.timeout = "20s";
              filters = [
                {convert_to = "atom";}
                {
                  modify_feed = ''
                    const labels = ${builtins.toJSON cfg.labels};
                    const url = feed.links[0]?.href || feed.id;
                    const repo = url.match(/^https:\/\/github\.com\/([^/]+\/[^/]+)(?:\/|$)/);
                    const label = labels[url] || (repo ? repo[1] : feed.title.value
                      .replace(/^Steam Community :: /, "")
                      .replace(/ :: Events(?: & Announcements)?$/, ""));
                    let image = repo ? ${builtins.toJSON cfg.repositoryImages}[repo[1]] : null;
                    if (repo && !image) {
                      try {
                        const response = await fetch("https://github.com/" + repo[1]);
                        if (response.status === 200) {
                          image = DOM.parse_document(response.body)
                            .select('meta[property="og:image"]')[0]?.attr("content");
                        }
                      } catch (error) {
                        console.error("Repository preview unavailable for " + repo[1]);
                      }
                    }
                    for (const entry of feed.entries) {
                      entry.title.value = "[" + label + "] " + entry.title.value;
                      if (image) {
                        entry.extensions.media = {
                          ...(entry.extensions.media || {}),
                          thumbnail: [{
                            name: "media:thumbnail",
                            value: null,
                            attrs: {url: image},
                            children: {}
                          }]
                        };
                      }
                    }
                  '';
                }
              ];
            };
          }
          {
            modify_feed = ''
              // RSS Funnel 0.1.4 drops these declarations during RSS-to-Atom merging.
              feed.namespaces = {
                ...feed.namespaces,
                media: "http://search.yahoo.com/mrss/",
                slash: "http://purl.org/rss/1.0/modules/slash/",
                wfw: "http://wellformedweb.org/CommentAPI/"
              };
              const links = new Set();
              feed.id = feed.links[0].href;
              feed.icon = "https://avatars.githubusercontent.com/u/102763838?v=4";
              feed.entries = feed.entries.filter(entry => {
                const link = entry.links.find(link => link.rel === "alternate")?.href
                  || entry.links[0]?.href || entry.id;
                if (links.has(link)) return false;
                links.add(link);
                if (entry.content?.value) entry.content.content_type = "html";
                if (entry.summary?.value) entry.summary.type = "Html";
                return true;
              });
              if (feed.entries.length) feed.updated = feed.entries[0].updated;
            '';
          }
        ];
      })
      cfg.groups;
  };
in {
  options.homelab.services.rss = {
    enable = lib.mkEnableOption "RSS Funnel grouped feeds";
    port = lib.mkOption {
      type = lib.types.port;
      default = 4080;
      description = "Loopback port for RSS Funnel";
    };
    groups = lib.mkOption {
      type = lib.types.attrsOf (lib.types.listOf lib.types.str);
      default = {};
      description = "Source feed URLs grouped under rss.<domain>/<name>";
    };
    labels = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Optional source labels keyed by the original feed's website URL";
    };
    repositoryImages = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Optional GitHub release thumbnail URLs keyed by owner/repository";
    };
  };

  config = lib.mkIf (homelab.enable && cfg.enable) {
    assertions =
      lib.mapAttrsToList (name: feeds: {
        assertion = builtins.match "[a-z0-9-]+" name != null && feeds != [];
        message = "RSS group ${name} must have a lowercase URL-safe name and at least one source feed";
      })
      cfg.groups;

    virtualisation.oci-containers.containers.rss-funnel = {
      image = "ghcr.io/shouya/rss-funnel:0.1.4@sha256:618e9c6440f8526a053484e3dcc86618c7e2f30762716e0a31d590ba977abc51";
      ports = ["127.0.0.1:${toString cfg.port}:4080"];
      volumes = ["${funnelConfig}:/funnel.yaml:ro"];
      environment = {
        RSS_FUNNEL_CONFIG = "/funnel.yaml";
        RSS_FUNNEL_BIND = "0.0.0.0:4080";
        RSS_FUNNEL_INSPECTOR_UI = "false";
      };
    };

    services.nginx.virtualHosts = lib.optionalAttrs (homelab.domain != null) {
      "rss.${homelab.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations = lib.mapAttrs' (name: _:
          lib.nameValuePair "= /${name}" {
            proxyPass = "http://127.0.0.1:${toString cfg.port}/${name}";
            extraConfig = ''
              set $args "";
              proxy_read_timeout 120s;
            '';
          })
        cfg.groups;
      };
    };
  };
}

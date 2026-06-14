{lib, ...}: {
  programs = {
    nushell = {
      enable = true;

      settings = {
        edit_mode = "vi";
        show_banner = false;
        completions.external = {
          enable = true;
          max_results = 200;
        };
        history = {
          file_format = "sqlite";
          sync_on_enter = true;
        };
      };

      shellAliases = {
        v = "nvim";
        ns = "nh search";
        ls = "exa --icons";

        upkg = "nix-shell -I nixpkgs=channel:nixpkgs-unstable -p";

        gpull = "git pull --ff-only";
        ga = "git add";
        gst = "git status";
        gcl = "git clone --recurse-submodules";
        gcmsg = "git commit --message";
        gd = "git diff";
      };

      extraEnv = ''
        $env.PROMPT_INDICATOR = ""
        $env.PROMPT_INDICATOR_VI_INSERT = ""
        $env.PROMPT_INDICATOR_VI_NORMAL = ""
        $env.PROMPT_MULTILINE_INDICATOR = ""
      '';
    };

    fzf = {
      enable = true;
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
      enableNushellIntegration = true;
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    yazi = lib.mkMerge [ {
      enableNushellIntegration = true;
    } ];

    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}

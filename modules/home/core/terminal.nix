{lib, ...}: {
  programs = {
    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      defaultKeymap = "viins";

      shellAliases = {
        v = "nvim";
        ns = "nh search";

        upkg = "nix-shell -I nixpkgs=channel:nixpkgs-unstable -p";

        gpull = "git pull --ff-only";
        ga = "git add";
        gst = "git status";
        gcl = "git clone --recurse-submodules";
        gcmsg = "git commit --message";
        gd = "git diff";
      };

      history = {
        size = 10000;
        ignoreAllDups = true;
      };
    };

    fzf = {
      enable = true;
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
      enableZshIntegration = true;
    };

    carapace = {
      enable = true;
      enableZshIntegration = true;
    };

    yazi = lib.mkMerge [
      {
        enableZshIntegration = true;
      }
    ];

    starship = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}

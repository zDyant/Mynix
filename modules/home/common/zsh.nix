{ lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";
    initContent = lib.mkAfter ''
    bindkey -M viins '^Y' autosuggest-accept
    bindkey -M viins '^E' autosuggest-accept
    '';

    shellAliases = {
      v = "nvim";
      ns = "nh search ";
      ls = "exa --icons";

      upkg = "nix-shell -I nixpkgs=channel:nixpkgs-unstable -p";

      gpull = "git pull --ff-only";
      ga = "git add";
      gst = "git status";
      gcl = "git clone --recurse-submodules";
      gcmsg = "git commit --message";
      gd = "git diff";
    };

    completionInit = ''
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
      setopt APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_IGNORE_DUPS
      setopt HIST_FIND_NO_DUPS
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

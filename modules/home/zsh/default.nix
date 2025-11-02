{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "copyfile"
        "copybuffer"
        "fancy-ctrl-z"
        "git"
        "colored-man-pages"
        "colorize"
      ];
    };

    shellAliases = {
      cd = "z";
      cdi = "zi";
      v = "nvim";
      nr = "nh os switch -H zdyant";
      ns = "nh search ";
      ls = "exa --icons";

	  da = "devbox add";

      gpull = "git pull --ff-only";

      pkg = "nix-shell -p";
      upkg = "nix-shell -I nixpkgs=channel:nixpkgs-unstable -p";
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

    envExtra = ''
      export GEMINI_API_KEY=$(cat /run/secrets/gemini_api_key)
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # enableBashIntegration = true;
    # options = [
    #   "--cmd cd"
    # ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}

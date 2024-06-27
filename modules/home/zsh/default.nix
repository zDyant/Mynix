{ pkgs, ...}: 

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "web-search"
        "git"
        "colored-man-pages"
        "colorize"
      ];
    };


    shellAliases = {
      cd = "z";
      cdi = "zi";
      ls = "exa --icons";

      ga = "git add";
      gst = "git status";
      gf = "git diff";
      gfs = "git diff --staged";
      gm = "git commit -m";
      gr = "git restore";
      grs = "git restore --staged";
      gpull = "git pull --ff-only";

      fi = "fzf --height 60% --preview='kitten icat --clear --transfer-mode=memory --stdin=no --place=\${FZF_PREVIEW_COLUMNS}x\${FZF_PREVIEW_LINES}@0x0 {}' && sleep 0.5 ; printf 'x1b_Ga=d,d=Ax1b\\\\' ";
      ff = "fzf -q '!png !jpg !jpeg !gif !bmp' --preview 'bat --color=always {}'";

      bevy = "nix-shell --run \"cargo run\"";

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

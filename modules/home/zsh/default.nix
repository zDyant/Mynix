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

    };

  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

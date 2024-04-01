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
        "git"
        "colored-man-pages"
        "colorize"
      ];
    };

    shellAliases = {
      cd = "z";
      cdi = "zi";
      ls = "exa --icons";
    };

  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

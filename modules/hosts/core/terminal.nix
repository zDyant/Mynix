{...}: {
  programs.zsh.enable = true;
  # programs.bash.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    # enableBashIntegration = true;
    flags = [
      "--cmd cd"
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.starship.enable = true;

}

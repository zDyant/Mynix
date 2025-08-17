{ ... }:
{
  environment.variables.EDITOR = "nvim";
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
}

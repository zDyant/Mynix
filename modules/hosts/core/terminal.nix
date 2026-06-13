{pkgs, ...}: {
  # programs.bash.enable = true;

  environment.systemPackages = [pkgs.nushell];

  programs.zoxide = {
    enable = true;
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

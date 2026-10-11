{config, ...}: {
  programs.tealdeer.enable = true;
  programs.navi = {
    enable = true;

    settings = {
      finder = {
        command = "fzf";
      };
      client.tealdeer = config.programs.tealdeer.enable;
    };
  };
}

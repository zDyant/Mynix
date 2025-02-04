{ ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    # font = {
    #   name = "JetBrainsMono Nerd Font";
    #   size = 11;
    # };
    settings = {
      mouse_hide_wait = 0;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      background_opacity = "0.5";
      background_blur = 5;

      # tab_bar_min_tabs            1
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

    };

  };
}

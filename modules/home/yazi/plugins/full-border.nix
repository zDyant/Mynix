{ pkgs, ... }:
let
  plugin_name = "full-border";
in
{
  programs.yazi = {
    initLua = ''
        require("${plugin_name}"):setup {
          -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
          type = ui.Border.PLAIN,
        }
    '';

    plugins.${plugin_name} = pkgs.yaziPlugins."${plugin_name}";
  };
}

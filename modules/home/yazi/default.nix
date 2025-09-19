{ pkgs, lib, ... }:
{
  imports = [
    ./plugins
  ];
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";
    settings = {
      # Mimetypes are ignored and 'Choose application' pops up if 'config.xdg.portal.xdgOpenUsePortal = true;'
      opener =
        let
          runCmd = "${lib.getExe' pkgs.xdg-utils "xdg-open"} \"$@\"";
        in
        {
          open = [
            {
              desc = "Open";
              orphan = true;
              run = runCmd;
            }
          ];
          play = [
            {
              desc = "Play";
              orphan = true;
              run = runCmd;
            }
          ];
        };
      #     opener = {
      #       # Load user's nvim config
      #       text = [  { run = ''nvim "$@" ''  ; for = "linux"; } ];
      #       pdf = [   { run = ''zathura "$@"''; for = "linux"; } ];
      # image = [ { run = ''imv "$@" ''   ; for = "linux"; } ];
      # video = [ { run = ''mpv "$@" ''   ; for = "linux"; } ];
      #     };
    };
  };
}

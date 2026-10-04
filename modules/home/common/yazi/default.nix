{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    extraPackages = [
      pkgs._7zz-rar
      pkgs.wl-clipboard
    ];
    initLua = ''
      require("full-border"):setup {
        type = ui.Border.PLAIN,
      }
    '';
    plugins = {
      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;
      };
      inherit
        (pkgs.yaziPlugins)
        full-border
        smart-enter
        smart-filter
        smart-paste
        toggle-pane
        wl-clipboard
        ;
    };
    keymap.mgr.prepend_keymap = [
      {
        on = "l";
        run = "plugin smart-enter";
        desc = "Enter directory or open file";
      }
      {
        on = "p";
        run = "plugin smart-paste";
        desc = "Paste into hovered directory or current directory";
      }
      {
        on = "F";
        run = "plugin smart-filter";
        desc = "Smart filter";
      }
      {
        on = "T";
        run = "plugin toggle-pane min-preview";
        desc = "Show or hide preview";
      }
      {
        on = "<C-p>";
        run = "plugin toggle-pane max-preview";
        desc = "Maximize or restore preview";
      }
      {
        on = "<C-y>";
        run = "plugin wl-clipboard";
        desc = "Copy selected files to system clipboard";
      }
      {
        on = ["c" "t"];
        run = ''shell -- test -f %h && ${pkgs.wl-clipboard}/bin/wl-copy --type text/plain < %h'';
        desc = "Copy hovered file contents to system clipboard";
      }
    ];
    settings = {
      # Mimetypes are ignored and 'Choose application' pops up if 'config.xdg.portal.xdgOpenUsePortal = true;'
      open.append_rules = [
        {
          mime = "*";
          use = "open";
        }
      ];
      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];
    };
  };
}

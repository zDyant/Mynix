{ lib, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = lib.getExe pkgs.zsh;
    keyMode = "vi";
    historyLimit = 10000;
    escapeTime = 0;
    prefix = "`";
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = ''
          set -g status-right '  #{cpu_percentage} '
        '';
      }
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set -g set-clipboard on
      set -g detach-on-destroy off
      set -g mouse on
      set -g bell-action any
      set -g status-interval 3
      set -g allow-passthrough on


      # Start selecting text with "v"
      bind-key -T copy-mode-vi 'v' send -X begin-selection 

      # Copy text with "y"
      bind -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel "pbcopy"

      # Paste yanked text with "Prefix + P" ("Prefix + p" goes to previous window)
      bind P paste-buffer
       
      # Don't exit copy mode when dragging with mouse
      unbind -T copy-mode-vi MouseDragEnd1Pane 

      bind v split-window -v
      bind h split-window -h
      bind f resize-pane -Z

      # Start windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set -g renumber-windows on # Automatically renumber windows when one is closed

      # Enable 256-color and true-color (24-bit) support in tmux
      set -g default-terminal "screen-256color" # Set terminal type for 256-color support
      set -ga terminal-overrides ",*256col*:Tc" # Override to enable true-color for compatible terminals

      set -g status-position top
      set -g status-left-length 100
      set -g status-style "bg=default"
      set -g status-left "#[bg=default,bold] #S #[bg=default,nobold] | "
      set -g window-status-format " #[bg=default] #I:#W"
      set -g window-status-current-format "#[bg=default,bold] #[underscore]#I:#W"
      set -g window-status-last-style "bg=default"
      set -g message-style "bg=default"
      set -g mode-style "bg=default"
      set -g pane-active-border-style "bg=default"
      set -g pane-border-style "bg=default"
    '';

  };
}

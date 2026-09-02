{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprshot = lib.getExe pkgs.hyprshot;
  wf-recorder = lib.getExe pkgs.wf-recorder;
  wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";
  mkMenu = menu: let
    configFile = pkgs.writeText "config.yaml" (
      lib.generators.toYAML {} {
        anchor = "bottom";
        margin_bottom = 8;

        font = config.stylix.fonts.monospace.name;
        color = config.lib.stylix.colors.withHashtag.base05;
        background = config.lib.stylix.colors.withHashtag.base00;
        border = config.lib.stylix.colors.withHashtag.base0A;
        border_width = 1;
        corner_r = 0;
        padding = 16;

        inherit menu;
      }
    );
  in
    pkgs.writeShellScriptBin "my-menu" ''
      pkill ${lib.getExe pkgs.wlr-which-key} ; exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
  menuBind = entries: "$mod, D, exec, ${lib.getExe (mkMenu entries)}";
in {
  # home.packages = with pkgs; [
  #   song-detect
  #   voice-dictate
  # ];

  wayland.windowManager.hyprland.settings.bind = [
    (menuBind [
      # Scripts
      {
        key = "C";
        desc = "  Color picker";
        cmd = ''${lib.getExe pkgs.hyprpicker} | ${wl-copy} '';
      }
      {
        key = "c";
        desc = "  Copy text on screen";
        cmd = ''
          ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp})" - \
            | ${lib.getExe pkgs.tesseract} - - \
            | ${wl-copy}
        '';
      }
      {
        key = "v";
        desc = " Voice Dictation";
        cmd = lib.getExe pkgs.voice-dictate;
      }
      {
        key = "m";
        desc = "  Detect Music";
        cmd = lib.getExe pkgs.song-detect;
      }

      # Recording
      {
        key = "r";
        desc = "  Record";
        submenu = let
          timestamp = "$(date +%Y-%m-%d_%H-%M-%S)";
        in [
          {
            key = "f";
            desc = "Record Fullscreen";
            cmd = "${wf-recorder} -f ~/Videos/${timestamp}.mp4 & notify-send 'Started recording'";
          }
          {
            key = "r";
            desc = "Record Region";
            cmd = "${wf-recorder} -g \"$(${lib.getExe pkgs.slurp})\" -f ~/Videos/${timestamp}.mp4 & notify-send 'Started recording'";
          }
          {
            key = "q";
            desc = "Stop Recording";
            cmd = "${lib.getExe pkgs.killall} -s SIGINT ${wf-recorder} && notify-send 'Stopped recording'";
          }
        ];
      }

      # Screenshot
      {
        key = "s";
        desc = "  Screenshot";
        submenu = [
          {
            key = "r";
            desc = "Capture Region";
            cmd = "${hyprshot} -m region";
          }
          {
            key = "c";
            desc = "[] Capture Region";
            cmd = "${hyprshot} -m region --clipboard-only";
          }
          {
            key = "f";
            desc = "Capture Region Freeze";
            cmd = "${hyprshot} -z -m region";
          }
          {
            key = "z";
            desc = "[] Capture Region Freeze";
            cmd = "${hyprshot} -z -m region --clipboard-only";
          }
        ];
      }

      # Interfaces
      {
        key = "o";
        desc = " Launch";
        submenu = [
          {
            key = "t";
            desc = "Tmux";
            cmd = "dms ipc tmux toggle";
          }
          {
            key = "w";
            desc = "Color wheel";
            cmd = "dms ipc color-picker toggle";
          }
          {
            key = "d";
            desc = "Download Manager";
            cmd = "${lib.getExe pkgs.kitty} --class float ${lib.getExe pkgs.surge}";
          }
          {
            key = "b";
            desc = "Bitwarden";
            cmd = let
              colors = config.lib.stylix.colors.withHashtag;

              rbw-pick = pkgs.writeShellApplication {
                name = "rbw-pick";
                runtimeInputs = [
                  pkgs.rbw
                  pkgs.fzf
                  pkgs.wl-clipboard
                ];

                text = ''
                  export SHELL=${lib.getExe pkgs.bash}
                  rbw unlock
                  rbw list --fields name,user \
                  | fzf \
                      --layout=reverse \
                      --prompt="󰌆  " \
                      --pointer="→ " \
                      --marker="✓ " \
                      --color="bg+:${colors.base0D},fg+:${colors.base00},pointer:${colors.base0D},hl+:${colors.base00}" \
                      --preview-window=bottom:3:wrap:border-top \
                      --delimiter $'\t' \
                      --preview '[ -n {2} ] && rbw get {1} {2} || rbw get {1}' \
                      --bind 'enter:execute({ [ -n {2} ] && rbw get {1} {2} || rbw get {1}; } | wl-copy)+abort'
                '';
              };
            in "${lib.getExe pkgs.kitty} --class float -o font_size=16 ${lib.getExe rbw-pick}";
          }
        ];
      }

      # Power menu don't work anymore. Idk why. too lazy.
      # Dms-shell already provides a power menu anyway
    ])
  ];
}

{
  lib,
  pkgs,
  ...
}: let
  package = pkgs.voxtype.override {vulkanSupport = true;};
  model = pkgs.fetchurl {
    url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en.bin";
    hash = "sha256-kh5M+Ghv3Zk9zQgaXaW2w2W/3hFi5ysI11rHUomSCx8=";
  };
in {
  home.packages = [package];

  xdg.configFile."voxtype/config.toml".source = (pkgs.formats.toml {}).generate "voxtype-config.toml" {
    state_file = "auto";
    hotkey.enabled = false;
    audio = {
      device = "default";
      max_duration_secs = 45;
    };
    whisper = {
      model = "${model}";
      language = "en";
      threads = 6;
    };
    output = {
      mode = "type";
      fallback_to_clipboard = true;
      notification = {
        on_recording_start = true;
        on_recording_stop = false;
        on_transcription = false;
      };
    };
  };

  systemd.user.services.voxtype = {
    Unit = {
      Description = "Voice dictation";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target" "pipewire.service"];
    };
    Service = {
      ExecStart = "${lib.getExe package} daemon";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}

{
  pkgs,
  ...
}:
let
  model = pkgs.fetchurl {
    url = "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-tiny.en.bin";
    hash = "sha256-kh5M+Ghv3Zk9zQgaXaW2w2W/3hFi5ysI11rHUomSCx8=";
  };
in
pkgs.writeShellApplication {
  name = "voice-dictate";

  runtimeInputs = with pkgs; [
    coreutils
    gnused
    libnotify
    sox
    whisper-cpp
    wtype
  ];

  text = ''
    set -euo pipefail

    max_seconds="''${VOICE_DICTATE_MAX_SECONDS:-45}"
    silence_seconds="''${VOICE_DICTATE_SILENCE_SECONDS:-1.2}"
    threads="''${VOICE_DICTATE_THREADS:-4}"

    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT

    audio="$tmpdir/dictation.wav"
    transcript="$tmpdir/transcript"

    notify-send -a voice-dictate "Dictation" "Listening..." || true

    set +e
    timeout --foreground "$max_seconds" \
      rec -q -r 16000 -c 1 -b 16 "$audio" \
        silence 1 0.1 1% 1 "$silence_seconds" 1%
    record_status="$?"
    set -e

    if [ "$record_status" -ne 0 ] && [ "$record_status" -ne 124 ]; then
      notify-send -a voice-dictate "Dictation failed" "Could not record from the microphone." || true
      exit "$record_status"
    fi

    if [ ! -s "$audio" ]; then
      notify-send -a voice-dictate "Dictation cancelled" "No speech was recorded." || true
      exit 0
    fi

    whisper-cli \
      --model ${model} \
      --file "$audio" \
      --language en \
      --threads "$threads" \
      --no-timestamps \
      --no-prints \
      --output-txt \
      --output-file "$transcript" >/dev/null

    text="$(
      tr '\n' ' ' < "$transcript.txt" \
        | sed -e 's/^[[:space:]]*//' \
              -e 's/[[:space:]]*$//' \
              -e 's/[[:space:]][[:space:]]*/ /g'
    )"

    if [ -z "$text" ]; then
      notify-send -a voice-dictate "Dictation cancelled" "No speech was detected." || true
      exit 0
    fi

    wtype "$text"
  '';
}

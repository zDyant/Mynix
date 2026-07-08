{pkgs, ...}:
pkgs.writeShellApplication {
  name = "song-detect";

  runtimeInputs = with pkgs; [
    coreutils
    gnused
    jq
    libnotify
    pulseaudio
    songrec
    wl-clipboard
  ];

  text = ''
    set -euo pipefail

    max_seconds="''${SONG_DETECT_MAX_SECONDS:-18}"
    request_interval="''${SONG_DETECT_REQUEST_INTERVAL:-4}"
    audio_device="''${SONG_DETECT_DEVICE:-}"

    if [ -z "$audio_device" ]; then
      default_sink="$(pactl get-default-sink 2>/dev/null || true)"

      if [ -n "$default_sink" ]; then
        audio_device="$default_sink.monitor"
      else
        audio_device="easyeffects_sink.monitor"
      fi
    fi

    notify-send -a song-detect "Song detection" "Listening to $audio_device..." || true

    tmpdir="$(mktemp -d)"
    trap 'rm -rf "$tmpdir"' EXIT

    output="$tmpdir/song.json"
    log="$tmpdir/song.log"

    args=(recognize --json --request-interval "$request_interval")
    if [ -n "$audio_device" ]; then
      args+=(--audio-device "$audio_device")
    fi

    set +e
    timeout --foreground "$max_seconds" songrec "''${args[@]}" >"$output" 2>"$log"
    status="$?"
    set -e

    if [ "$status" -eq 124 ]; then
      notify-send -a song-detect "Song detection" "No match before timeout." || true
      exit 0
    fi

    if [ "$status" -ne 0 ] || [ ! -s "$output" ]; then
      message="$(sed -n '1,4p' "$log" | tr '\n' ' ')"
      notify-send -a song-detect "Song detection failed" "''${message:-Could not detect a song.}" || true
      exit "$status"
    fi

    title="$(
      jq -r '
        .track.title
        // .title
        // .matches[0].track.title
        // empty
      ' "$output"
    )"
    artist="$(
      jq -r '
        .track.subtitle
        // .subtitle
        // .artist
        // .matches[0].track.subtitle
        // empty
      ' "$output"
    )"

    if [ -z "$title" ]; then
      notify-send -a song-detect "Song detection" "No match found." || true
      exit 0
    fi

    if [ -n "$artist" ]; then
      result="$title - $artist"
    else
      result="$title"
    fi

    printf '%s\n' "$result"
    printf '%s\n' "$result" | wl-copy
    notify-send -a song-detect "Song detected" "$result"
  '';
}

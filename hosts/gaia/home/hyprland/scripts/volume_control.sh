#!/usr/bin/env bash
# Volume and microphone controls. Notifications are best effort.
set -euo pipefail

source_args=()
case "${1:---get}" in
--toggle-mic | --get-mic-icon | --mic-inc | --mic-dec) source_args=(--default-source) ;;
esac

get_volume() {
	if [[ $(pamixer "${source_args[@]}" --get-mute) == true ]]; then
		echo Muted
	else
		printf '%s%%\n' "$(pamixer "${source_args[@]}" --get-volume)"
	fi
}

get_icon() {
	if [[ $(pamixer "${source_args[@]}" --get-mute) == true ]]; then
		if ((${#source_args[@]})); then echo microphone-sensitivity-muted; else echo audio-volume-muted; fi
	elif ((${#source_args[@]})); then
		echo microphone-sensitivity-high
	else
		local volume
		volume=$(pamixer --get-volume)
		if ((volume <= 30)); then echo audio-volume-low; elif ((volume <= 60)); then echo audio-volume-medium; else echo audio-volume-high; fi
	fi
}

notify_user() {
	local volume label
	volume=$(pamixer "${source_args[@]}" --get-volume)
	label=Volume
	if ((${#source_args[@]})); then label=Mic-Level; fi
	notify-send -e -h "int:value:$volume" -h string:x-canonical-private-synchronous:volume_notif \
		-u low -i "$(get_icon)" "$label: $(get_volume)" || true
}

case "${1:---get}" in
--get) get_volume ;;
--get-icon | --get-mic-icon) get_icon ;;
--inc | --mic-inc)
	pamixer "${source_args[@]}" -u
	pamixer "${source_args[@]}" -i 5
	notify_user
	;;
--dec | --mic-dec)
	pamixer "${source_args[@]}" -u
	pamixer "${source_args[@]}" -d 5
	notify_user
	;;
--toggle | --toggle-mic)
	pamixer "${source_args[@]}" -t
	notify_user
	;;
*) get_volume ;;
esac

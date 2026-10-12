#!/usr/bin/env bash
set -euo pipefail
# Pinned portal v1.4.3 contract: multiple directory save path output debug.
multiple=$1 directory=$2 save=$3 suggested=$4 out=$5 debug=$6
[[ $debug == 1 ]] && set -x
: >"$out"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
args=(--chooser-file="$work/selection")
title='Select file'
if [[ $directory == 1 && $save == 0 ]]; then
	# The portal keymap suppresses cwd-file output when cancelling with q.
	export YAZI_CONFIG_HOME="$PORTAL_DIRECTORY_CONFIG"
	args+=(--cwd-file="$work/directory")
	title='Select folder: s confirms current folder, q cancels'
fi
if [[ $save == 1 ]]; then title='Save file'; fi
kitty --class filechooser --title "$title" -e yazi "${args[@]}" "${suggested:-$HOME}" || exit 0
if [[ $directory == 1 && $save == 0 ]]; then
	[[ -s $work/directory ]] || exit 0
	selected=$(cat "$work/directory")
	[[ -d $selected ]] && printf '%s\n' "$selected" >"$out"
elif [[ -s $work/selection ]]; then
	if [[ $multiple == 1 && $save == 0 ]]; then
		cat "$work/selection" >"$out"
	else
		head -n 1 "$work/selection" >"$out"
	fi
fi

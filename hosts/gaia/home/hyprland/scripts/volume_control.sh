#!/usr/bin/env bash
set -euo pipefail

case "${1:-}" in
--inc)
	pamixer -u
	pamixer -i 5
	;;
--dec)
	pamixer -u
	pamixer -d 5
	;;
*)
	printf 'Usage: volume-control --inc|--dec\n' >&2
	exit 2
	;;
esac

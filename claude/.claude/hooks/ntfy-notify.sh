#!/usr/bin/env bash
# Claude Code Notification hook: sends an ntfy notification with a session recap.
# See Explorations/Claude Code ntfy notification hook/spec.md in homelab-vault.

set -uo pipefail

# shellcheck disable=SC2317  # used in later tasks (error paths, happy path)
log() { echo "[ntfy-notify] $*" >&2; }

: "${NTFY_TOKEN:=}"
if [[ -z "$NTFY_TOKEN" ]]; then
  exit 0
fi

exit 0

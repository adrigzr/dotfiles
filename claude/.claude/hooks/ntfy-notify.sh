#!/usr/bin/env bash
# Claude Code Notification hook: sends an ntfy notification with a session recap.
# See Explorations/Claude Code ntfy notification hook/spec.md in homelab-vault.

set -uo pipefail

NTFY_URL="https://ntfy.adrigzr.dev/apps"
CURL_BIN="${CURL_BIN:-curl}"

log() { echo "[ntfy-notify] $*" >&2; }

: "${NTFY_TOKEN:=}"
if [[ -z "$NTFY_TOKEN" ]]; then
  exit 0
fi

if ! command -v jq >/dev/null 2>&1; then
  log "jq not found; skipping"
  exit 0
fi
if ! command -v "$CURL_BIN" >/dev/null 2>&1; then
  log "$CURL_BIN not found; skipping"
  exit 0
fi

payload="$(cat)"
if ! message="$(jq -r '.message // empty' <<<"$payload" 2>/dev/null)"; then
  log "malformed stdin json; skipping"
  exit 0
fi

title="Claude Code"
body="$message"

"$CURL_BIN" -sS --max-time 10 --connect-timeout 5 \
  -H "Authorization: Bearer $NTFY_TOKEN" \
  -H "Title: $title" \
  -H "Tags: robot" \
  -H "Priority: 3" \
  -d "$body" \
  "$NTFY_URL" \
  || { log "curl failed with exit $?"; exit 0; }

exit 0

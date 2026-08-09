# RTK — Rust Token Killer

A hook rewrites most commands to `rtk <cmd>` transparently; no action needed.

- `rtk proxy <cmd>` — run raw, unfiltered. Use when a filter could mangle the result;
  the lint filter has reported a pass on a failing run.
- `rtk gain` / `rtk discover` — savings analytics.

# Security

This repository is a **Gate/Prove** evaluation plane for agent and MCP tool calls.

- Fixtures are labeled ATT&CK techniques. They do **not** include exploit payloads, shell one-liners, or disable-EDR procedures.
- `ALLOW` on destructive / provision / decommission requires a HITL prove token **and** `approved: true`. Agent `thought` and `model_confidence` never approve.
- Kill-switch: `AAG_KILL_SWITCH=1` or a file at `AAG_KILL_SWITCH_FILE` (default `artifacts/KILL`).
- Default write path is **SIMULATE** (no side effects). The MCP `serve` loop evaluates `gate_check` only — it never runs `shell.exec` or disable-control tools.

Report issues to the maintainer. Do not file weaponization requests.

Commercial evaluation of Gate/Prove gaps: [Instant Audit $499](https://a2zsoc.com/productized-services#instant-audit-tripwire) · [consultation](https://a2zsoc.com/consultation)

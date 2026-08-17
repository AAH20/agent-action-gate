# Agent Action Gate

Gate/Prove runtime for **agent and MCP tool calls**.

Normalize tool intent → deny unknown → **never treat model confidence as approval** → HITL prove on destructive / provision / decommission → Action Ledger (hash chain).

Extracted from GRC_Claw `@grc-claw/agent-policy-firewall`. This repo is the sharp foundry slice: one command, no cathedral.

<!-- mcp-name: io.github.AAH20/agent-action-gate -->

**Commercial (how this is sold):** [$499 Instant Audit](https://a2zsoc.com/productized-services#instant-audit-tripwire) and [consultation](https://a2zsoc.com/consultation) on [a2zsoc.com](https://a2zsoc.com).

## Why this exists (revenue + cost)

AI-agent companies do not pay for “another MCP.” They pay to **stop unattended destructive tools** and to **prove Gate/Prove gaps** before SOC 2 Type I, PE diligence, or insurance renewal.

| Cost driver | What this gate does | Buyer outcome |
|---|---|---|
| Ungated `shell.exec` / disable-control / decommission | DENY unless HITL prove token + `approved` | Avoid production blast |
| Agent “95% sure” | `never_equate_intent_to_approval: true` | Intent ≠ ledger proof |
| Write tools fire on first thought | Default **SIMULATE** (no side effects) | FDE minutes, not incident cost |
| No audit trail | Append-only Action Ledger with hash chain | Diligence packet |

Hard rule: **never equate agent intent or model score to human approval.**

Illustrative cost sketch (not a quote): `make bench`.

## Quick start

```bash
make demo
```

```bash
PYTHONPATH=. python3 -m aag demo
PYTHONPATH=. python3 -m aag check fixtures/t1059_unattended_shell.json
PYTHONPATH=. python3 -m aag bench
```

Unattended high-tier calls **DENY** even at 0.99 confidence. ALLOW needs `AAG_PROVE_TOKEN` (or `--prove-token`) **and** `approved: true`.

```bash
export AAG_PROVE_TOKEN='replace-me'
PYTHONPATH=. python3 -m aag check fixtures/proved_decommission.json --prove-token "$AAG_PROVE_TOKEN"
```

Kill-switch: `AAG_KILL_SWITCH=1` or touch `artifacts/KILL`.

## MCP stdio server

This process **never executes** tools. Clients call `gate_check` before they would invoke a destructive tool.

```bash
PYTHONPATH=. python3 -m aag serve
```

Cursor / Claude example (`mcpServers`):

```json
{
  "agent-action-gate": {
    "command": "python3",
    "args": ["-m", "aag", "serve"],
    "cwd": "/path/to/agent-action-gate",
    "env": { "PYTHONPATH": ".", "AAG_PROVE_TOKEN": "replace-me" }
  }
}
```

Docker / registry image:

```bash
docker run --rm -i ghcr.io/aah20/agent-action-gate:0.2.0
```

Official MCP Registry name: `io.github.AAH20/agent-action-gate`

## Envelope

Every decision includes:

- `never_equate_intent_to_approval: true`
- `allow_auto_execute` (false on unattended high tiers)
- `mode`: `deny` | `simulate` | `allow`
- `ledger_id` / `receipt_hash`
- CTAs: Instant Audit + consultation

## Library mapper

Same Gate/Prove policy from Python without the stdio loop:

```python
from aag.gate import AgentActionGate
from aag.mcp import evaluate_mcp_call

gate = AgentActionGate(prove_token="replace-me")
evaluate_mcp_call(gate, {"params": {"name": "shell.exec", "arguments": {"note": "no payload"}}})
```

## Fixtures (labeled, not payloads)

| File | Technique | Expected |
|---|---|---|
| `t1059_unattended_shell.json` | T1059 | DENY unattended destructive |
| `t1078_read_identity.json` | T1078 | ALLOW read |
| `t1562_impair_defenses.json` | T1562 | DENY unattended destructive |
| `write_ticket_simulate.json` | — | SIMULATE write |
| `proved_decommission.json` | T1578 | ALLOW only with HITL token |

## Layout

```text
aag/
  gate.py      HITL + kill-switch + unknown deny
  ledger.py    hash-chained JSONL
  server.py    MCP stdio (gate_check, ledger_verify)
  mcp.py       MCP tools/call mapper (no execution)
  cost.py      illustrative avoidance sketch
  demo.py      fixture runner
fixtures/      ATT&CK-tagged cases
server.json    MCP Registry metadata
tests/         Gate/Prove + MCP contract
```

## Paid evaluation (not free prove)

If you deploy agents or MCP servers and need a Gate/Prove read before SOC 2, PE diligence, or insurance:

→ **[$499 Instant Audit](https://a2zsoc.com/productized-services#instant-audit-tripwire)**  
→ **[consultation](https://a2zsoc.com/consultation)** (sprint / vCISO)

Unpaid take-homes: refuse — run `make demo` and buy Instant Audit.

## License

MIT

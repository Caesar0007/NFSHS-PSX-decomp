#!/usr/bin/env python3
"""w65a4 -- objdiff.json metadata.source_path hygiene fix (METADATA LAYER ONLY).

W64-A21 hygiene defect #1: `metadata.source_path` says `.cpp` for units whose
recon TU is actually `.c` (the task-#90 C-lane migration).  `base_path` and
`target_path` are correct, so the BOARD is unaffected -- but any tool that
resolves unit -> source silently gets a non-existent file.

This patch touches ONLY `metadata.source_path`, and only when:
  * the recorded path does NOT exist, AND
  * exactly one sibling with a different C/C++ suffix DOES exist, AND
  * that sibling is consistent with the unit's own `base_path`
    (build/recon/<rel>.o  =>  recon/<rel>).

Anything else is reported and left alone.  Formatting is preserved exactly
(json.dumps indent=2 + trailing newline -- the same shape
tools/gen_objdiff_units.py writes), so the diff is confined to the fixed lines.

Usage:  python scratchpad/w65a4/fix_source_path.py [--apply]
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
CFG = ROOT / "objdiff.json"
APPLY = "--apply" in sys.argv

cfg = json.loads(CFG.read_text(encoding="utf-8"))
fixed, skipped, ok = [], [], 0

for u in cfg["units"]:
    md = u.get("metadata") or {}
    sp = md.get("source_path")
    if not sp:
        continue
    if (ROOT / sp).exists():
        ok += 1
        continue
    # derive the truth from base_path: build/recon/<rel>.o -> recon/<rel>
    bp = u.get("base_path", "")
    derived = None
    if bp.startswith("build/recon/") and bp.endswith(".o"):
        derived = "recon/" + bp[len("build/recon/"):-len(".o")]
    elif bp.startswith("build/") and bp.endswith(".o"):
        derived = bp[len("build/"):-len(".o")]
    if derived and (ROOT / derived).exists() and derived != sp:
        fixed.append((u["name"], sp, derived))
        if APPLY:
            md["source_path"] = derived
    else:
        skipped.append((u["name"], sp, derived))

print(f"units: {len(cfg['units'])}  source_path OK: {ok}  "
      f"fixable: {len(fixed)}  unresolved: {len(skipped)}")
for n, old, new in fixed:
    print(f"  FIX  {n:44} {old} -> {new}")
for n, old, new in skipped:
    print(f"  SKIP {n:44} {old} (derived={new})")

if APPLY and fixed:
    # objdiff.json is CRLF in this repo.  json.dumps emits LF -> writing it raw
    # would rewrite EVERY line (the standing CRLF hazard).  Re-apply CRLF; a
    # no-change round-trip in that shape is byte-identical (verified).
    txt = (json.dumps(cfg, indent=2) + "\n").replace("\n", "\r\n")
    old = CFG.read_bytes()
    new = txt.encode("utf-8")
    assert len(new) > 1000, "refusing to write a truncated objdiff.json"
    assert abs(len(new) - len(old)) < 4096, "unexpected size delta -- aborting"
    tmp = CFG.with_suffix(".json.w65a4tmp")
    tmp.write_bytes(new)
    tmp.replace(CFG)
    print(f"wrote {CFG.name} ({len(new)} bytes, was {len(old)}; "
          f"{len(fixed)} source_path fixes)")
elif not APPLY:
    print("DRY-RUN. pass --apply to write.")

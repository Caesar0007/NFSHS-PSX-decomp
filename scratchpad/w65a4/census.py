#!/usr/bin/env python3
"""w65a4 -- THE WAVE'S ACCEPTANCE SHEET (honest end-state census).

Three independent instruments, each with its anti-vacuity leg:

  1 BOARD      objdiff-cli report generate (x2, must be identical) -- the
               per-row fuzzy%.  Blind to reloc identity; NOT blind to branch
               words, instruction count, or st_size.
  2 GATE       tools/tugate.py over every TU that owns a sub-100 board row --
               verify_asm's own compile + normalisers.  Blind to branch TARGETS.
  3 BRDIST     tools/brdist.py over the same TU set -- per-branch DISTANCE
               compare.  This is what closes the gate's branch blind spot.

Cross-classifying 1 x 2 x 3 reproduces the W64-A21 taxonomy and tells us what
each class costs TODAY:

  a GATE_FAIL    gate FAIL  + board <100          -> ordinary near-miss
  d BRANCH_REAL  gate PASS  + board <100 + brdist divergence
  c ARTIFACT     gate PASS  + board <100, no brdist divergence
                 (the literal-D_ / st_size families)
  x GATE-ONLY    gate FAIL  + board 100           -> the board is blind here

Usage:
    python scratchpad/w65a4/census.py            # full run
    python scratchpad/w65a4/census.py --board    # board + reproducibility only
"""
import json
import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r"C:\Temp\nfs4-decomp")
CLI = r"C:/Temp/nfs4-clean/objdiff-cli.exe"
PY = sys.executable
OUTDIR = ROOT / "scratchpad" / "w65a4"
BOARD_ONLY = "--board" in sys.argv


def board(tag):
    p = OUTDIR / f"report_{tag}.json"
    r = subprocess.run([CLI, "report", "generate", "-o", str(p)],
                       cwd=str(ROOT), capture_output=True, text=True)
    if r.returncode:
        sys.exit(f"objdiff-cli failed:\n{r.stdout[-800:]}\n{r.stderr[-800:]}")
    rep = json.load(open(p, encoding="utf-8"))
    rows = {}
    for u in rep["units"]:
        for f in u.get("functions", []):
            if f["name"].startswith(".L"):
                continue
            rows[(u["name"], f["name"])] = round(
                float(f.get("fuzzy_match_percent", 0.0)), 4)
    return rows, rep.get("measures", {})


# ---------------------------------------------------------------------------
# 0. REFRESH EVERY BASE OBJECT FIRST.
#
# `objdiff-cli report generate` does NOT build -- it reads build/recon/**.o as
# they are on disk (W64-A21 sec.7).  During a 20-belt wave those objects are a
# mix of committed-source builds and leftover PROBE-PATCHED variants, so a board
# read without a rebuild is neither honest nor reproducible.  The w65a4 smoke
# test proved this empirically: 4 units whose every board row read 100.00 grew a
# brdist divergence the moment their TU was recompiled from committed source.
#
# `tools/build.py --skip-asm` is exactly objdiff.json's own `custom_make`, so
# this is the board's declared build step, not a re-implementation.
# ---------------------------------------------------------------------------
if "--no-rebuild" not in sys.argv:
    print("== 0. REBUILD all base objects (tools/build.py --skip-asm) ==", flush=True)
    rb = subprocess.run([PY, "tools/build.py", "--skip-asm"], cwd=str(ROOT),
                        capture_output=True, text=True)
    skips = [l for l in rb.stdout.splitlines() if l.strip().startswith("SKIP ")]
    print(f"   exit={rb.returncode}  TUs that failed to build: {len(skips)}")
    for s in skips:
        print("   " + s.strip())

print("== 1. BOARD (x2, reproducibility) ==", flush=True)
r1, m1 = board("a")
r2, m2 = board("b")
print(f"   run1 {len(r1)} rows, {sum(1 for v in r1.values() if v >= 100)} at 100%")
print(f"   run2 {len(r2)} rows, {sum(1 for v in r2.values() if v >= 100)} at 100%")
print(f"   run1 == run2 : {r1 == r2}")
print(f"   matched_code_percent : {m1.get('matched_code_percent')}")
print(f"   fuzzy_match_percent  : {m1.get('fuzzy_match_percent')}")
json.dump({f"{k[0]}|{k[1]}": v for k, v in r1.items()},
          open(OUTDIR / "board_rows.json", "w"), indent=0)
if BOARD_ONLY:
    sys.exit(0)

sub = sorted({k[0] for k, v in r1.items() if v < 100})
LIMIT = next((int(a.split("=")[1]) for a in sys.argv if a.startswith("--limit=")), 0)
if LIMIT:
    sub = sub[:LIMIT]
    print(f"\n[SMOKE TEST] --limit={LIMIT}: restricted to {sub}")
print(f"\n== 2. GATE over the {len(sub)} units owning a sub-100 row ==",
      flush=True)

# unit name -> recon TU path, straight out of objdiff.json's (now correct) metadata
cfg = json.loads((ROOT / "objdiff.json").read_text(encoding="utf-8"))
unit_src = {u["name"]: u.get("metadata", {}).get("source_path") for u in cfg["units"]}

# tugate only prints the FAILING fns, so it cannot tell PASS from NO-ORACLE.
# Drive verify_asm's OWN module per TU instead (one compile per TU, exactly like
# tugate) and evaluate precisely the fns that own a sub-100 board row.
# Anti-drift (12H): this loads tools/verify_asm.py; only the driver is new.
GATE_DRIVER = r'''
import sys, re, difflib, importlib.util
from pathlib import Path
ROOT = Path(r"C:\Temp\nfs4-decomp"); sys.path.insert(0, str(ROOT/"tools"))
cpp, wanted = sys.argv[1], sys.argv[2].split("\x1f")
sys.argv = [sys.argv[0], cpp, "__none__"]
sp = importlib.util.spec_from_file_location("va", ROOT/"tools"/"verify_asm.py")
V = importlib.util.module_from_spec(sp)
try: sp.loader.exec_module(V)
except SystemExit as e:
    if not hasattr(V, "_name2addr"):
        print("!!COMPILEFAIL"); raise SystemExit(0)
for n in wanted:
    try: b = V.oracle(n)
    except Exception: b = None
    if b is None: print(f"{n}\tNOORACLE"); continue
    try: a = V.ours(n)
    except Exception: a = None
    if not a: print(f"{n}\tNOTINOBJ"); continue
    if len(a) == len(b):                       # verify_asm's w59-a9 dead-%hi collapse
        for i in range(len(a)):
            mo = re.match(r"lui (\w+),0$", a[i]); me = re.match(r"lui (\w+),\d+$", b[i])
            if mo and me and mo.group(1) == me.group(1): b[i] = a[i]
    d = [l for l in difflib.unified_diff(a, b, lineterm="")
         if l[0] in "+-" and not l.startswith(("+++","---"))]
    print(f"{n}\t" + ("PASS" if not d else f"FAIL:{len(d)}"))
'''
(OUTDIR / "_gate_driver.py").write_text(GATE_DRIVER, encoding="utf-8")

gate = {}          # (unit, fn) -> 'PASS' | 'FAIL:n' | 'NOORACLE' | 'NOTINOBJ'
for i, unit in enumerate(sub):
    src = unit_src.get(unit)
    if not src or not (ROOT / src).exists():
        print(f"   [{i+1}/{len(sub)}] {unit}: NO RECON TU ({src}) -- skipped")
        continue
    fns = [k[1] for k, v in r1.items() if k[0] == unit and v < 100]
    r = subprocess.run([PY, str(OUTDIR / "_gate_driver.py"), src, "\x1f".join(fns)],
                       cwd=str(ROOT), capture_output=True, text=True)
    if "!!COMPILEFAIL" in r.stdout:
        for fn in fns:
            gate[(unit, fn)] = "COMPILEFAIL"
        print(f"   [{i+1}/{len(sub)}] {unit}: TU FAILED TO COMPILE", flush=True)
        continue
    n = 0
    for ln in r.stdout.splitlines():
        if "\t" not in ln:
            continue
        fn, verdict = ln.split("\t", 1)
        gate[(unit, fn)] = verdict.strip()
        n += 1
    print(f"   [{i+1}/{len(sub)}] {unit}: {n}/{len(fns)} rows gated", flush=True)
json.dump({f"{k[0]}|{k[1]}": v for k, v in gate.items()},
          open(OUTDIR / "gate_rows.json", "w"), indent=0)

print(f"\n== 3. BRDIST over the same {len(sub)} units ==", flush=True)
BRFN = re.compile(r"^(\S+)\s+(?:(\d+) offset diffs (.*)|BRANCH COUNT (\d+) vs (\d+))")
brd = {}
for i, unit in enumerate(sub):
    src = unit_src.get(unit)
    if not src or not (ROOT / src).exists():
        continue
    r = subprocess.run([PY, "tools/brdist.py", src], cwd=str(ROOT),
                       capture_output=True, text=True)
    hits = 0
    for ln in r.stdout.splitlines():
        if ln.startswith("#"):
            continue
        m = BRFN.match(ln.rstrip())
        if m:
            brd[(unit, m.group(1))] = ln.strip()
            hits += 1
    print(f"   [{i+1}/{len(sub)}] {unit}: {hits} branch divergence(s)", flush=True)
json.dump({f"{k[0]}|{k[1]}": v for k, v in brd.items()},
          open(OUTDIR / "brdist_rows.json", "w"), indent=0)

# CONTROL LEG: W63 established "0 brdist divergence on 100%-rows tree-wide".
# Re-test that claim on a deterministic sample of units where EVERY row is 100,
# so a clean result on the sub-100 set cannot be read as vacuous.
allclean = sorted({k[0] for k in r1} - set(sub))
step = max(1, len(allclean) // 40)
sample = allclean[::step][:40]
print(f"\n== 3b. BRDIST CONTROL: {len(sample)} of {len(allclean)} all-100 units ==",
      flush=True)
ctl_hits = 0
for i, unit in enumerate(sample):
    src = unit_src.get(unit)
    if not src or not (ROOT / src).exists():
        continue
    r = subprocess.run([PY, "tools/brdist.py", src], cwd=str(ROOT),
                       capture_output=True, text=True)
    for ln in r.stdout.splitlines():
        if ln.startswith("#") or not ln.strip():
            continue
        if BRFN.match(ln.rstrip()):
            ctl_hits += 1
            print(f"   CONTROL HIT {unit}: {ln.strip()}")
print(f"   control divergences on all-100 units: {ctl_hits}")

# The gate + brdist steps recompile TUs, i.e. they rewrite the very objects
# objdiff reads.  After a clean --skip-asm rebuild that must be a no-op; re-read
# the board and prove it, otherwise the classification below is comparing a board
# and a gate taken at two different states (the W64-A21 sec.7 trap).
print("\n== 3c. BOARD RE-READ after gate+brdist (must equal run 1) ==", flush=True)
r3, _ = board("c")
print(f"   board unchanged by gate/brdist recompiles: {r3 == r1}")
if r3 != r1:
    moved = [k for k in r3 if r3[k] != r1.get(k)]
    print(f"   {len(moved)} row(s) moved -- classification uses the RE-READ board:")
    for k in sorted(moved)[:25]:
        print(f"     {k[0]:34} {k[1][:52]:54} {r1.get(k)} -> {r3[k]}")
    r1 = r3

print("\n== 4. CROSS-CLASSIFICATION ==")
cls = {"a": [], "d": [], "c": [], "x": [], "?": []}
for key, fuzzy in sorted(r1.items()):
    g = gate.get(key)
    b = key in brd
    if fuzzy < 100:
        if g is None:
            cls["?"].append((key, fuzzy, g, b))
        elif g.startswith("FAIL"):
            cls["a"].append((key, fuzzy, g, b))
        elif g == "PASS":
            cls["d" if b else "c"].append((key, fuzzy, g, b))
        else:
            cls["?"].append((key, fuzzy, g, b))
    else:
        if g and g.startswith("FAIL"):
            cls["x"].append((key, fuzzy, g, b))
for k, label in (("a", "GATE_FAIL (gate FAIL + board<100)"),
                 ("d", "BRANCH_REAL (gate PASS + board<100 + brdist hit)"),
                 ("c", "ARTIFACT (gate PASS + board<100, no brdist hit)"),
                 ("x", "GATE-ONLY (gate FAIL + board 100 -- board blind)"),
                 ("?", "UNRESOLVED (no gate verdict / NO ORACLE)")):
    print(f"  {k} {label:58} {len(cls[k])}")
json.dump({k: [[f"{a[0]}|{a[1]}", b, c, d] for a, b, c, d in v]
           for k, v in cls.items()},
          open(OUTDIR / "classified.json", "w"), indent=1)
print("\nwrote board_rows.json / gate_rows.json / brdist_rows.json / classified.json")

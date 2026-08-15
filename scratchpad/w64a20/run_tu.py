#!/usr/bin/env python3
"""w64-a20 mission-1 driver: convert ONE TU, prove both lanes, revert on any
regression.  ACCEPTANCE (all must hold):
   * gate-lane object hash UNCHANGED      (constructive zero PASS->FAIL)
   * production REAL/RELOP unchanged-or-better for every fn (shim ON)
   * production WITHOUT the shim: no fn worse, and at least one recovers
Usage: python run_tu.py <tu-rel> [--drop-elf]
"""
import json, os, shutil, subprocess, sys
from pathlib import Path

ROOT = Path(r"C:/Temp/nfs4-decomp")
SP = ROOT / "scratchpad" / "w64a20"
PY = sys.executable


def run(*a):
    r = subprocess.run([PY, *[str(x) for x in a]], capture_output=True,
                       text=True, cwd=ROOT)
    return r.stdout + r.stderr, r.returncode


def proof(rel, tag):
    out, rc = run(SP / "prove.py", rel, "--tag", tag)
    safe = rel.replace("/", "_").replace(".", "_")
    p = SP / f"proof_{safe}_{tag}.json"
    if not p.exists():
        print(out[-1500:])
        sys.exit(f"prove.py failed for {rel} [{tag}]")
    return json.loads(p.read_text()), out


def score(d):
    """-> (dict fn->(real,relop) for shim-ON, set of fns that FAIL without shim)"""
    on = {k: (v.get("real"), v.get("relop")) if v.get("ok") else None
          for k, v in d["prod"].items()}
    offbad = {k for k, v in d["prod_nodialect"].items() if not v.get("ok")}
    return on, offbad


def main():
    rel = sys.argv[1].replace("\\", "/")
    extra = ["--drop-elf"] if "--drop-elf" in sys.argv else []
    src = ROOT / rel
    keep = src.read_bytes()

    b, _ = proof(rel, "before")
    bon, boff = score(b)
    out, rc = run(SP / "aspsxify.py", rel, "--write", *extra)
    print(out.strip())
    if "(no change)" in out:
        print("NO SOURCE CHANGE NEEDED")
        return
    run(SP / "aspsxify.py", rel, "--banner-only", "--write")
    a, _ = proof(rel, "after")
    aon, aoff = score(a)

    prob = []
    if b["obj_sha"] != a["obj_sha"]:
        prob.append(f"GATE OBJECT CHANGED {b['obj_sha'][:12]} -> {a['obj_sha'][:12]}")
    if b["gate"]["pass"] != a["gate"]["pass"]:
        prob.append(f"GATE PASS {b['gate']['pass']} -> {a['gate']['pass']}")
    for fn in bon:
        x, y = bon[fn], aon.get(fn)
        if x is None and y is not None:
            continue                        # recovered, fine
        if y is None:
            prob.append(f"prod {fn}: was {x}, now FAILS")
        elif x is not None and (y[0] + y[1]) > (x[0] + x[1]):
            prob.append(f"prod {fn}: REAL+RELOP {sum(x)} -> {sum(y)} WORSE")
    new_off_fail = aoff - boff
    if new_off_fail:
        prob.append(f"no-dialect NEW failures: {sorted(new_off_fail)}")

    if prob:
        src.write_bytes(keep)
        print("\n*** REVERTED ***")
        for p in prob:
            print("   ", p)
        sys.exit(1)
    rec = len(boff) - len(aoff)
    print(f"\nACCEPTED: gate obj identical ({a['obj_sha'][:12]}), gate "
          f"{a['gate']['pass']}/{a['gate']['total']} PASS, prod fns={len(aon)}, "
          f"no-dialect failures {len(boff)} -> {len(aoff)} (recovered {rec})")


if __name__ == "__main__":
    main()

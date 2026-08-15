#!/usr/bin/env python3
"""W64-A19 link census -- reloc-filtered unresolved + COMMONs, exact-name.

Anti-vacuity discipline (both historic gate bugs):
  * nm/objdump fed in BATCHES (never one glob -> ARG_MAX vacuous-nm).
  * EXACT mangled names compared; never VA-grouped (hidden-phantom).
  * "unresolved" is filtered by an actual RELOCATION reference (objdump -r);
    a dangling symtab entry is not a link error.
  * every exclusion is counted and printed.

Usage: python scratchpad/w65a6/census.py [recon|src]
Writes scratchpad/w65a6/census_<lane>.json + .txt
"""
import collections
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
BIN = "C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-"
NM = BIN + "nm"
OD = BIN + "objdump"
OUT = ROOT / "scratchpad" / "w65a6"
EXCLUDED = ("diffsrc", "scratch", "scratchpad", "pbuild")
BATCH = 30


def collect(pats):
    objs, excl = [], collections.Counter()
    for p in pats:
        for o in sorted(ROOT.joinpath("build").glob(p)):
            parts = o.relative_to(ROOT / "build").parts
            if parts[0] in EXCLUDED:
                excl[parts[0]] += 1
                continue
            objs.append(o)
    return objs, excl


def run_nm(objs):
    """-> defined {sym: [obj]}, undef {sym: [obj]}, common {sym: [(obj,size)]}"""
    defined = collections.defaultdict(list)
    undef = collections.defaultdict(list)
    common = collections.defaultdict(list)
    for i in range(0, len(objs), BATCH):
        batch = objs[i:i + BATCH]
        p = subprocess.run([NM, "-S"] + [str(o) for o in batch],
                           capture_output=True, text=True)
        if p.returncode and not p.stdout:
            sys.exit("nm failed: " + p.stderr[:400])
        cur = None
        for line in p.stdout.splitlines():
            line = line.rstrip()
            if not line:
                continue
            if line.endswith(".o:"):
                cur = line[:-1].replace("\\", "/")
                continue
            m = re.match(r"^([0-9a-fA-F]{8})?\s*(?:([0-9a-fA-F]{8})\s+)?"
                         r"([A-Za-z])\s+(\S+)$", line)
            if not m:
                continue
            size, typ, sym = m.group(2), m.group(3), m.group(4)
            if typ == "U":
                undef[sym].append(cur)
            elif typ == "C":
                common[sym].append((cur, int(size, 16) if size else 0))
            else:
                defined[sym].append(cur)
    return defined, undef, common


def reloc_refs(objs, names):
    hits = collections.Counter()
    sites = collections.defaultdict(set)
    for i in range(0, len(objs), BATCH):
        batch = objs[i:i + BATCH]
        p = subprocess.run([OD, "-r"] + [str(o) for o in batch],
                           capture_output=True, text=True)
        cur = None
        for line in p.stdout.splitlines():
            mh = re.match(r"^(.*\.o):\s+file format ", line)
            if mh:
                cur = mh.group(1).replace("\\", "/")
                continue
            m = re.match(r"^[0-9a-f]{8}\s+(R_MIPS\S+)\s+(\S+)", line)
            if m:
                sym = m.group(2).split("+")[0]
                if sym in names:
                    hits[sym] += 1
                    sites[sym].add(cur)
    return hits, sites


def main():
    lane = sys.argv[1] if len(sys.argv) > 1 else "recon"
    pats = {"recon": ["recon/**/*.o", "asm/**/*.o"],
            "src": ["src/**/*.o", "asm/**/*.o"]}[lane]
    objs, excl = collect(pats)
    assert objs, "no objects -- refusing a vacuous census"
    defined, undef, common = run_nm(objs)
    undef_names = set(undef) - set(defined) - set(common)
    hits, sites = reloc_refs(objs, undef_names)
    real = sorted(hits)
    benign = sorted(undef_names - set(real))

    rep = [f"lane={lane}  objects={len(objs)}  excluded={dict(excl)}",
           f"defined global symbols : {len(defined)}",
           f"COMMON (.comm) symbols : {len(common)}",
           f"undefined names (raw)  : {len(undef_names)}",
           f"  reloc-referenced (REAL link errors): {len(real)}"
           f"  ({sum(hits.values())} reloc sites)",
           f"  symtab-only (benign)               : {len(benign)}", "",
           "== REAL UNRESOLVED ==" ]
    for s in real:
        rep.append(f"{s}\t{hits[s]}\t{';'.join(sorted(x.split('build/')[-1] for x in sites[s]))}")
    rep += ["", "== COMMONS =="]
    for s in sorted(common):
        for o, sz in common[s]:
            rep.append(f"{s}\t{sz}\t{o.split('build/')[-1]}")
    (OUT / f"census_{lane}.txt").write_text("\n".join(rep) + "\n")
    (OUT / f"census_{lane}.json").write_text(json.dumps({
        "objects": len(objs), "excluded": dict(excl),
        "defined": {k: v for k, v in defined.items()},
        "real_unres": {s: sorted(sites[s]) for s in real},
        "real_unres_hits": dict(hits),
        "benign": benign,
        "common": {k: v for k, v in common.items()},
    }, indent=1))
    print("\n".join(rep[:8]))


main()

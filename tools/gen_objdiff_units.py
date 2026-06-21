#!/usr/bin/env python3
"""gen_objdiff_units.py [--apply] — populate per-module objdiff units for the
whole recon tree so decomp.dev shows every module (not just the 7 hand-wired ones).

WHAT IT DOES (pure reorganization — the built binary is byte-invariant):
  For each recon/**/*.cpp, look at the global/static .text symbols it DEFINES.
  Any of those that currently sit in the src/main.c or src/front.c catch-all as a
  plain `INCLUDE_ASM("asm/nonmatchings/<seg>", SYM);` line gets RELOCATED into a
  new mirrored stub src/<reldir>/<mod>.c. That stub, compiled WITHOUT -DSKIP_ASM,
  assembles the oracle asm into expected/src/<reldir>/<mod>.c.o — the per-module
  TARGET. The matching objdiff unit pairs it against build/recon/<reldir>/<mod>.cpp.o
  (our reconstruction = the BASE).

WHY ONLY INCLUDE_ASM LINES (not C-bodies): a function with a real C body in
  main.c is matched work in the main.c effort. Leaving it there (and NOT carving
  it) preserves that progress and guarantees each function is counted in exactly
  ONE unit. Each carved symbol is claimed once (first recon module wins), so no
  double-count across units.

  main.c / front.c remain as the REMAINDER catch-alls (C-bodies + any INCLUDE_ASM
  not owned by a recon module).

Run `tools/build.py --out expected --no-link` + `tools/build.py --skip-asm`
afterwards to (re)build targets+bases, then objdiff-cli to regenerate the report.

Default is DRY-RUN (prints the plan). Pass --apply to write files.
"""
import re
import subprocess
import sys
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OBJDUMP = r"C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe"
APPLY = "--apply" in sys.argv

ASM_MAIN = ROOT / "asm" / "nonmatchings" / "main"
ASM_FRONT = ROOT / "asm" / "nonmatchings" / "front"
oracle_main = {p.name[:-2] for p in ASM_MAIN.glob("*.s")}
oracle_front = {p.name[:-2] for p in ASM_FRONT.glob("*.s")}

# Modules already wired as their own (flat) units — skip so we don't duplicate.
PREWIRED = {"aiinit", "aitune", "aiscript", "aiperson", "aidatarecord", "aiphysic"}

INCASM_RE = re.compile(r'^\s*INCLUDE_ASM\("asm/nonmatchings/(main|front)",\s*(\S+?)\s*\);')


def parse_catch_all(path):
    """Return {sym: seg} for every INCLUDE_ASM line in a catch-all .c file."""
    out = {}
    for ln in path.read_text().splitlines():
        m = INCASM_RE.match(ln)
        if m:
            out[m.group(2)] = m.group(1)
    return out


def text_syms(obj):
    """All F .text symbols (global + local static) defined by an object."""
    r = subprocess.run([OBJDUMP, "-t", str(obj)], capture_output=True, text=True)
    syms = []
    for ln in r.stdout.splitlines():
        if " F .text\t" in ln or re.search(r"\sF\s\.text\s", ln):
            parts = ln.split()
            if parts:
                syms.append(parts[-1])
    return syms


main_c = ROOT / "src" / "main.c"
front_c = ROOT / "src" / "front.c"
incasm_main = parse_catch_all(main_c)   # sym -> 'main'
incasm_front = parse_catch_all(front_c)  # sym -> 'front'
# A removable catch-all symbol: present as INCLUDE_ASM in the catch-all AND has
# an oracle .s in the matching segment.
removable = {}
for s, seg in incasm_main.items():
    if (seg == "main" and s in oracle_main) or (seg == "front" and s in oracle_front):
        removable[s] = seg
for s, seg in incasm_front.items():
    if (seg == "front" and s in oracle_front) or (seg == "main" and s in oracle_main):
        removable.setdefault(s, seg)

claimed = {}          # sym -> seg (to delete from the catch-alls)
new_units = []        # objdiff unit dicts
stub_writes = []      # (path, text)
skipped_empty = 0

for cpp in sorted(ROOT.glob("recon/**/*.cpp")):
    rel = cpp.relative_to(ROOT / "recon")          # e.g. game/common/audiocmn.cpp
    mod = rel.stem
    if mod in PREWIRED and rel.parent.as_posix() == "game/common":
        continue
    obj = ROOT / "build" / "recon" / (str(rel) + ".o")
    if not obj.exists():
        continue
    owned = []
    for s in text_syms(obj):
        if s in claimed:
            continue
        seg = removable.get(s)
        if seg is not None:
            owned.append((s, seg))
            claimed[s] = seg
    if not owned:
        skipped_empty += 1
        continue
    # Write the mirrored stub.
    rel_c = rel.with_suffix(".c")                   # game/common/audiocmn.c
    stub_path = ROOT / "src" / rel_c
    lines = ['#include "common.h"', ""]
    for s, seg in owned:
        lines.append(f'INCLUDE_ASM("asm/nonmatchings/{seg}", {s});')
    lines.append("")
    stub_writes.append((stub_path, "\n".join(lines)))
    new_units.append({
        "name": rel.parent.as_posix() + "/" + mod,
        "target_path": f"expected/src/{rel_c.as_posix()}.o",
        "base_path": f"build/recon/{rel.as_posix()}.o",
        "metadata": {"source_path": f"recon/{rel.as_posix()}"},
    })

print(f"recon modules scanned, {len(new_units)} will get a unit "
      f"({skipped_empty} had no removable catch-all symbol).")
print(f"symbols to relocate out of the catch-alls: {len(claimed)}")
seg_counts = {}
for s, seg in claimed.items():
    seg_counts[seg] = seg_counts.get(seg, 0) + 1
print(f"  by segment: {seg_counts}")
print(f"largest new units:")
for u in sorted(new_units, key=lambda u: -u['target_path'].count('/'))[:0]:
    pass
top = sorted(stub_writes, key=lambda x: -x[1].count("INCLUDE_ASM"))[:12]
for p, t in top:
    print(f"  {t.count('INCLUDE_ASM'):4} {p.relative_to(ROOT).as_posix()}")

if not APPLY:
    print("\nDRY-RUN. Re-run with --apply to write stubs + rewrite catch-alls + objdiff.json.")
    sys.exit(0)

# ---- APPLY ----
for p, t in stub_writes:
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(t)
print(f"wrote {len(stub_writes)} stub .c files under src/")

# Strip claimed INCLUDE_ASM lines from the catch-alls.
for path in (main_c, front_c):
    kept = []
    dropped = 0
    for ln in path.read_text().splitlines():
        m = INCASM_RE.match(ln)
        if m and m.group(2) in claimed:
            dropped += 1
            continue
        kept.append(ln)
    path.write_text("\n".join(kept) + "\n")
    print(f"{path.name}: dropped {dropped} relocated INCLUDE_ASM lines")

# Rewrite objdiff.json: keep the existing main + 6 AI units, add a front catch-all
# unit (if absent), then all new per-module units (sorted).
cfg_path = ROOT / "objdiff.json"
cfg = json.loads(cfg_path.read_text())
existing = cfg["units"]
have_front = any(u["name"] == "front" for u in existing)
if not have_front:
    # Insert front catch-all right after main for symmetry.
    front_unit = {
        "name": "front",
        "target_path": "expected/src/front.c.o",
        "base_path": "build/src/front.c.o",
        "metadata": {"source_path": "src/front.c"},
    }
    idx = next((i for i, u in enumerate(existing) if u["name"] == "main"), -1)
    existing.insert(idx + 1, front_unit)

cfg["units"] = existing + sorted(new_units, key=lambda u: u["name"])
cfg_path.write_text(json.dumps(cfg, indent=2) + "\n")
print(f"objdiff.json: {len(cfg['units'])} units total "
      f"(was {len(existing) - (0 if have_front else 1)}, +{len(new_units)} module units"
      f"{'' if have_front else ' + front catch-all'})")

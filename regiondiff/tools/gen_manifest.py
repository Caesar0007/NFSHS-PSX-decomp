#!/usr/bin/env python3
"""gen_manifest.py -- (re)build regiondiff/MANIFEST.tsv, the regional
reconstruction work plan.

One row per (function, byte-variant group) from regiondiff/variants.tsv
(regionrecon.py's relocation-masked dedup: 207 functions have ONE variant
across all their regions, 11 have real inter-region logic splits).

Columns:
  function     base ground-truth name (CHANGED) or func_<va> (REGION-ONLY)
  class        CHANGED | REGION-ONLY (from the repr region's INDEX.tsv)
  group        regions sharing this byte variant, '+'-joined short names
  repr_region  the region whose oracle gates this row (first of group in
               preference order USA,AU,FR-DE,JPN,UK-ES-IT,UK-SW)
  region_va    the function's VA in repr_region
  words        oracle instruction rows in repr_region
  unit         owning base TU (MATCH_PROGRESS.txt unit) or regiononly/<fn>
  candidate    expected recon file: regiondiff/recon/<repr_region>/<unit>.<ext>

Run from anywhere: python regiondiff/tools/gen_manifest.py
"""
import re, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent.parent
RD = ROOT / 'regiondiff'
PREF = ['USA', 'AU', 'FR-DE', 'JPN', 'UK-ES-IT', 'UK-SW']

def fnfile(name):
    return re.sub(r'[^\w]', '_', name)[:80]

# unit map from the main board
unit_of = {}
for ln in (ROOT / 'MATCH_PROGRESS.txt').read_text().splitlines():
    m = re.match(r'0x[0-9A-Fa-f]{8}\s+[\d.]+%\s+(\S+)\s+(\S+)', ln.strip())
    if m:
        unit_of[m.group(2)] = m.group(1)

# per-region INDEX: name -> (class, region_va, words)
index = {}
for rdir in sorted((RD / 'oracles').iterdir()):
    if not rdir.is_dir():
        continue
    short = rdir.name.replace('NFS4-R-', '')
    rows = {}
    p = rdir / 'INDEX.tsv'
    for ln in p.read_text().splitlines()[1:]:
        f = ln.split('\t')
        if len(f) >= 5:
            rows[f[3]] = (f[0], f[1], f[4])
    index[short] = rows

out = ['function\tclass\tgroup\trepr_region\tregion_va\twords\tunit\tcandidate']
n_rows = 0
for ln in (RD / 'variants.tsv').read_text().splitlines()[1:]:
    name, distinct, groups = ln.split('\t')
    for grp in groups.split(' || '):
        m = re.match(r'^(.*?)\((\d+)w\)$', grp.strip())
        regs = (m.group(1) if m else grp).split('+')
        repr_r = next((p for p in PREF if p in regs), regs[0])
        rrows = index.get(repr_r, {})
        cls, rva, words = rrows.get(name, ('?', '', m.group(2) if m else ''))
        # INDEX names REGION-ONLY fns func_<region_va>; variants.tsv uses the
        # same, so direct lookup covers both classes.
        if cls == '?':
            # fall back to any region in the group that has the row
            for r in regs:
                if name in index.get(r, {}):
                    cls, rva, words = index[r][name]
                    repr_r = r
                    break
        # reclassify from the m2c corpus' hand-stub markers: a slice that is
        # really DATA (no jr $ra) or a byte-exact PsyQ kernel-gate thunk is
        # not reconstruction work -- flag it so the board excludes it.
        mc = RD / 'm2c' / f'NFS4-R-{repr_r}' / (fnfile(name) + '.c')
        if mc.exists():
            head = mc.read_text(errors='replace')[:400]
            if 'DATA misdetected' in head:
                cls = 'DATA-BLOB'
            elif '/* PsyQ' in head or 'kernel gate' in head:
                cls = 'LIB-THUNK'
        unit = unit_of.get(name)
        if unit is None:
            unit = 'regiononly/' + fnfile(name)
        base_tu = None
        for ext in ('.cpp', '.c'):
            if (ROOT / 'recon' / (unit + ext)).exists():
                base_tu = unit + ext
                break
        cand = f'regiondiff/recon/NFS4-R-{repr_r}/' + (base_tu or unit + '.cpp')
        out.append('\t'.join([name, cls, '+'.join(regs), repr_r, rva,
                              str(words), unit, cand]))
        n_rows += 1

(RD / 'MANIFEST.tsv').write_text('\n'.join(out) + '\n', newline='\n')
print(f'MANIFEST.tsv: {n_rows} rows '
      f'({sum(1 for l in out[1:] if chr(9)+"CHANGED"+chr(9) in l)} CHANGED)')

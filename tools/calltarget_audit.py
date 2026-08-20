#!/usr/bin/env python3
"""w64a21 calltarget_audit.py -- THE FOURTH BLIND SPOT: reloc TARGET identity.

verify_asm is reloc-NAME lenient by design (AGENT_GUIDE 0c), and the board's
fuzzy_match_percent ignores relocation differences entirely (measured: a report
generated with `-c functionRelocDiffs=none` is row-for-row identical to the
default).  So a `jal` to the WRONG FUNCTION is invisible to BOTH lanes.

This walks every objdiff unit with `-c functionRelocDiffs=all` (the only setting
that surfaces reloc diffs), keeps the R_MIPS_26 (jal/j) sites where the two
sides name DIFFERENT symbols, and reports the pairs where both names are in
configs/symbol_addrs.txt at DIFFERENT addresses -- i.e. a provably different
call target, not a splat-`D_<VA>`-vs-C-symbol spelling.
"""
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
CLI = str(ROOT / 'tools' / 'objdiff' / 'objdiff-cli.exe')   # vendored 3.8.0; the repo IS the version pin
sys.path.insert(0, str(Path(__file__).parent))
from objclass import addrs, mnem, reloc_of  # noqa: E402


def unit_diff(unit):
    with tempfile.NamedTemporaryFile('w', suffix='.json', delete=False) as f:
        out = f.name
    r = subprocess.run([CLI, 'diff', '-u', unit, '-o', out, '--format', 'json',
                        '-c', 'functionRelocDiffs=all'],
                       cwd=str(ROOT), capture_output=True, text=True)
    if r.returncode != 0:
        Path(out).unlink(missing_ok=True)
        return None
    d = json.load(open(out, encoding='utf-8'))
    Path(out).unlink(missing_ok=True)
    return d


def main():
    cfg = json.load(open(ROOT / 'objdiff.json', encoding='utf-8'))
    A = addrs()
    hits = []
    units = [u['name'].replace('\\', '/') for u in cfg['units']]
    if len(sys.argv) > 1:
        units = [u for u in units if any(a in u for a in sys.argv[1:])]
    for i, unit in enumerate(units):
        d = unit_diff(unit)
        if not d:
            continue
        L = {s['name']: s for s in d['left'].get('symbols', [])
             if s.get('kind') == 'SYMBOL_FUNCTION'}
        Ls, Rs = d['left'].get('symbols', []), d['right'].get('symbols', [])
        for rs in Rs:
            if rs.get('kind') != 'SYMBOL_FUNCTION':
                continue
            ls = L.get(rs.get('name'))
            if not ls:
                continue
            li, ri = ls.get('instructions', []), rs.get('instructions', [])
            for a, b in zip(li, ri):
                if b.get('diff_kind') in (None, 'DIFF_NONE'):
                    continue
                ai, bi = a.get('instruction', {}), b.get('instruction', {})
                if mnem(ai) != mnem(bi) or mnem(bi) not in ('jal', 'j'):
                    continue
                ra, rb = reloc_of(ai, Ls), reloc_of(bi, Rs)
                if not ra or not rb or ra[1] == rb[1]:
                    continue
                # A SECTION-relative R_MIPS_26 (`.text`+addend, emitted for a
                # file-static callee -- methodology 3.12 #12) is rendered by
                # objdiff as the name of the symbol that CONTAINS the target, so
                # a name difference there proves nothing about the address.
                if any(n is None or n.startswith(('.', '[')) for n in (ra[1], rb[1])):
                    continue
                if ra[2] or rb[2]:            # any addend: same reason
                    continue
                va, vb = A.get(ra[1]), A.get(rb[1])
                if va is None or vb is None or va == vb:
                    continue
                hits.append((unit, rs['name'], ra[1], hex(va), rb[1], hex(vb)))
        if (i + 1) % 50 == 0:
            print(f'  ...{i+1}/{len(units)} units', file=sys.stderr, flush=True)

    print(f"{len(hits)} PROVEN wrong-call-target sites "
          f"(both names known, different VAs)")
    for unit, fn, tn, tv, on, ov in hits:
        print(f"  {unit}  {fn}")
        print(f"      retail calls {tn} @{tv}")
        print(f"      ours   calls {on} @{ov}")


if __name__ == '__main__':
    main()

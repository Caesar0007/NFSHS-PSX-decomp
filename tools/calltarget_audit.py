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

# Resolve the checkout that owns this tool; hardcoding the primary checkout
# makes a clean linked-worktree audit report unrelated dirty-tree results.
ROOT = Path(__file__).resolve().parents[1]
CLI = str(ROOT / 'tools' / 'objdiff' / 'objdiff-cli.exe')   # vendored 3.8.0; the repo IS the version pin
NM = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-nm.exe'
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


def coequal_definition_vas(A):
    """Resolve natural global names through explicit VA-suffixed aliases.

    A duplicated static helper can have one natural name in configs while its
    exported copy is represented by a suffixed oracle key.  When both global
    symbols are co-equal in one reconstructed object, the suffix is direct
    evidence for that definition's retail VA.  This is link-resolution
    evidence, not a heuristic name lookup.
    """
    objects = sorted(o for o in (ROOT / 'build' / 'recon').rglob('*.o')
                     if 'diffsrc' not in o.parts)
    groups = {}
    for start in range(0, len(objects), 64):
        batch = objects[start:start + 64]
        result = subprocess.run(
            [NM, '-A', '-g', '--defined-only', '-n', *map(str, batch)],
            cwd=str(ROOT), capture_output=True, text=True)
        for line in result.stdout.splitlines():
            match = re.match(r'^(.*):([0-9A-Fa-f]+)\s+T\s+(\S+)$', line)
            if match:
                groups.setdefault((match.group(1), int(match.group(2), 16)), []) \
                      .append(match.group(3))
    candidates = {}
    resolved_groups = 0
    ambiguous_groups = 0
    for names in groups.values():
        explicit = [(name, A[name]) for name in names if name in A and
                    name.upper().endswith('_%08X' % A[name])]
        if len(explicit) == 1:
            va = explicit[0][1]
            for name in names:
                candidates.setdefault(name, set()).add(va)
            resolved_groups += 1
        elif len(explicit) > 1:
            ambiguous_groups += 1
    resolved = {name: next(iter(vas)) for name, vas in candidates.items()
                if len(vas) == 1}
    ambiguous_groups += sum(1 for vas in candidates.values() if len(vas) > 1)
    return resolved, resolved_groups, ambiguous_groups


def main():
    cfg = json.load(open(ROOT / 'objdiff.json', encoding='utf-8'))
    A = addrs()
    definition_vas, alias_groups_resolved, alias_groups_ambiguous = \
        coequal_definition_vas(A)
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
                va = definition_vas.get(ra[1], A.get(ra[1]))
                vb = definition_vas.get(rb[1], A.get(rb[1]))
                if va is None or vb is None or va == vb:
                    continue
                hits.append((unit, rs['name'], ra[1], hex(va), rb[1], hex(vb)))
        if (i + 1) % 50 == 0:
            print(f'  ...{i+1}/{len(units)} units', file=sys.stderr, flush=True)

    print(f"{len(hits)} PROVEN wrong-call-target sites "
          f"(both names known, different VAs)")
    print(f"  co-equal definition aliases: {alias_groups_resolved} resolved, "
          f"{alias_groups_ambiguous} ambiguous")
    for unit, fn, tn, tv, on, ov in hits:
        print(f"  {unit}  {fn}")
        print(f"      retail calls {tn} @{tv}")
        print(f"      ours   calls {on} @{ov}")
    sys.exit(1 if hits else 0)


if __name__ == '__main__':
    main()

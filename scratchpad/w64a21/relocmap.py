#!/usr/bin/env python3
"""w64a21 relocmap.py -- resolve the RELOC_UNK pairs by IMPLIED BASE.

objdiff only reports the reloc sites where the two spellings DIFFER, and those
are exactly the ones we need: target side carries splat's synthetic `D_<VA>` /
`func_<VA>` label, our side carries the project's C symbol (+addend).  For every
such site the target VA is known exactly, so

    implied_base[our_symbol] = target_VA - our_addend

If a symbol's implied base is CONSISTENT across every site it appears at (and,
where the symbol is in configs/symbol_addrs.txt, equal to that VA), the two
spellings are the same address and the rows are byte-identical after link ->
the board is under-counting, not us mis-relocating.  An INCONSISTENT symbol is a
real wrong-target suspect.
"""
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
sys.path.insert(0, str(Path(__file__).parent))
from objclass import addrs, sym_va  # noqa: E402

SYMRE = re.compile(r'%(?:hi|lo|gp_rel)\(([^)]*)\)|(?:\bjal|\bj)\s+([^\s,]+)')


def parse(f):
    """formatted operand -> (name, addend) or None."""
    if not f:
        return None
    m = SYMRE.search(f)
    if not m:
        return None
    s = m.group(1) if m.group(1) is not None else m.group(2)
    a = 0
    m2 = re.match(r'^(.*?)([+-]0x[0-9A-Fa-f]+|[+-]\d+)$', s)
    if m2:
        s = m2.group(1)
        a = int(m2.group(2), 16) if 'x' in m2.group(2) else int(m2.group(2))
    return s, a


def main():
    rows = [json.loads(l) for l in open(ROOT / 'scratchpad/w64a21/objclass.jsonl')]
    sites = defaultdict(list)      # our-name -> [(implied_base, unit, fn, target)]
    unresolved = []
    for r in rows:
        for x in r.get('rows', []):
            if x['cls'] not in ('RELOC_UNK', 'RELOC_DIFF', 'RELOC_ALIAS'):
                continue
            t, o = parse(x.get('target')), parse(x.get('ours'))
            if not t or not o:
                continue
            tva = sym_va(t[0])
            if tva is None:
                unresolved.append((r['unit'], r['fn'], x['target'], x['ours']))
                continue
            sites[o[0]].append((tva + t[1] - o[1], r['unit'], r['fn'], t[0]))

    A = addrs()
    consistent, inconsistent, contradict = {}, {}, {}
    for name, lst in sites.items():
        bases = {b for b, *_ in lst}
        if len(bases) == 1:
            b = bases.pop()
            if name in A and A[name] != b:
                contradict[name] = (b, A[name], len(lst))
            else:
                consistent[name] = (b, len(lst))
        else:
            inconsistent[name] = sorted(bases), len(lst), lst[:4]

    print(f"symbols with a CONSISTENT implied base: {len(consistent)}")
    print(f"symbols with an INCONSISTENT implied base: {len(inconsistent)}")
    for n, (bs, c, ex) in sorted(inconsistent.items()):
        print(f"  !! {n}: bases {[hex(b) for b in bs]} over {c} sites")
        for b, u, f, t in ex:
            print(f"       {hex(b)}  {u}  {f}  (target {t})")
    print(f"symbols contradicting configs/symbol_addrs.txt: {len(contradict)}")
    for n, (b, a, c) in sorted(contradict.items()):
        print(f"  !! {n}: implied {hex(b)} vs symbol_addrs {hex(a)} ({c} sites)")
    print(f"unresolvable target spellings: {len(unresolved)}")
    seen = set()
    for u, f, t, o in unresolved:
        k = (t, o)
        if k in seen:
            continue
        seen.add(k)
        print(f"  ?  target={t}  ours={o}   ({u} {f})")

    json.dump({'consistent': {k: v[0] for k, v in consistent.items()},
               'inconsistent': {k: [hex(x) for x in v[0]] for k, v in inconsistent.items()},
               'contradict': {k: [hex(v[0]), hex(v[1])] for k, v in contradict.items()}},
              open(ROOT / 'scratchpad/w64a21/relocmap.json', 'w'), indent=1)


if __name__ == '__main__':
    main()

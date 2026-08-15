#!/usr/bin/env python3
"""w64a21 merge.py -- join the three census sources into the classification table.

 1. GATE      scratchpad/w64a21/gate.jsonl     (verify_asm's own compile+normalizers,
                                                whole-TU, run 2026-08-15 17:11-17:15)
 2. BOARD     scratchpad/w64a21/board_after.json (objdiff report AFTER the gate run
                                                freshened every one of the 82 objects)
 3. MECHANISM scratchpad/w64a21/objclass.jsonl  (objdiff-cli per-instruction diff kinds)

Classes (mission taxonomy):
  a  GATE_FAIL      gate FAIL and board <100 -- they agree, ordinary near-miss
  c  RELOC_RENDER   gate PASS, board <100, every diffing row is a reloc-spelling or
                    data-rendering artifact (splat `D_<VA>` vs our C symbol, co-equal
                    XDEF alias, .word/alabel) -> byte-identical after link
  d  BRANCH_REAL    gate PASS, board <100, at least one BRANCH/JUMP DESTINATION word
                    differs -> a REAL divergence the gate normalises to `T` (04Q law)
  b  LANE_GAP       gate PASS, board <100, and the residual is an opcode/arg/count
                    difference -> the two lanes really did compile different things
  e  STALE          board 100.00 at regen (the committed row was stale)
"""
import json
import sys
from pathlib import Path

ROOT = Path(r'C:\Temp\nfs4-decomp')
S = ROOT / 'scratchpad' / 'w64a21'


def main():
    rows = json.load(open(S / 'worklist.json'))
    gate = {}
    for ln in open(S / 'gate.jsonl'):
        if not ln.startswith('{'):
            continue
        r = json.loads(ln)
        if r['ok']:
            gate[r['src']] = r['fns']          # later runs overwrite earlier
    mech = {}
    for ln in open(S / 'objclass.jsonl'):
        r = json.loads(ln)
        mech[(r['unit'], r['fn'])] = r

    out = []
    for r in rows:
        g = gate.get(r['src'], {})
        gv = g.get(r['fn'])
        m = mech.get((r['unit'], r['fn']), {})
        cls_counts = m.get('classes', {})
        after = r['after']
        rec = dict(r)
        rec['gate'] = gv[0] if gv else None
        rec['gate_ours'] = gv[1] if gv else None
        rec['gate_oracle'] = gv[2] if gv else None
        rec['mech'] = cls_counts
        rec['mech_err'] = m.get('err')

        if gv is None:
            rec['class'] = 'X_NO_GATE'
        elif after is not None and after >= 100.0:
            rec['class'] = 'e_STALE' if gv[0] == 0 else 'X_BOARD100_GATEFAIL'
        elif gv[0] > 0:
            rec['class'] = 'a_GATE_FAIL'
        else:
            hard = {k: v for k, v in cls_counts.items()
                    if k in ('OTHER', 'STRUCT', 'RELOC_DIFF')}
            if cls_counts.get('BRANCH_DEST'):
                rec['class'] = 'd_BRANCH_REAL'
            elif hard:
                rec['class'] = 'b_LANE_GAP'
            elif cls_counts:
                rec['class'] = 'c_RELOC_RENDER'
            else:
                rec['class'] = 'e_STALE'      # no diffs found at regen
        out.append(rec)

    json.dump(out, open(S / 'classified.json', 'w'), indent=1)

    from collections import Counter
    c = Counter(x['class'] for x in out)
    print('CLASS COUNTS')
    for k in sorted(c):
        print(f'  {k:<22} {c[k]}')
    print()
    for k in sorted(c):
        print(f'--- {k} ---')
        for x in sorted(out, key=lambda y: y['va']):
            if x['class'] != k:
                continue
            print(f"  {x['va']:<11} board {x['board']:6.2f} -> {x['after']:6.2f}  "
                  f"gate {str(x['gate']):>5}  {x['unit']:<28} {x['fn'][:56]}  {x['mech']}")
        print()


if __name__ == '__main__':
    main()

#!/usr/bin/env python3
"""mkwiring.py -- render SPEC_w66a1_ALL.json as paste-ready build.py fragments,
so the orchestrator never re-types a regex.  Emits WIRING_fragment.py.
"""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
spec = json.loads((HERE / 'SPEC_w66a1_ALL.json').read_text())


def rows(d, keyorder):
    out = []
    for rel, fns in d.items():
        out.append('    %r: {' % rel)
        for fn, rr in fns.items():
            out.append('        %r: [' % fn)
            for r in rr:
                out.append('            {')
                if '_note' in r:
                    out.append('             "_note": %r,' % r['_note'])
                for k in keyorder:
                    if k in r:
                        out.append('             %r: %r,' % (k, r[k]))
                out.append('            },')
            out.append('        ],')
        out.append('    },')
    return out


L = ['# ---- w66-a1: PASTE INTO tools/build.py -------------------------------',
     '# 1. apply scratchpad/w66a1/branch_retarget.patch (adds the applier +',
     '#    an EMPTY PER_FN_BRANCH_RETARGET table + the 3 lane call sites).',
     '# 2. fill that table with:', 'PER_FN_BRANCH_RETARGET = {']
L += rows(spec['branch_retarget'], ('branch', 'after'))
L += ['}', '',
      '# 3. MERGE the entry below INTO the existing PER_FN_TEXT_MOVES dict',
      '#    (sim.cpp has NO prior key today; a duplicate dict key is SILENTLY',
      '#    SHADOWED by Python -- grep the table span before adding).',
      '#    The wrapper name here exists only so this file parses.',
      '_MERGE_INTO_PER_FN_TEXT_MOVES = {']
L += rows(spec['text_moves_replace'], ('take', 'after', 'copy'))
L += ['}']
(HERE / 'WIRING_fragment.py').write_text('\n'.join(L) + '\n')
print('wrote WIRING_fragment.py (%d lines)' % (len(L) + 1))

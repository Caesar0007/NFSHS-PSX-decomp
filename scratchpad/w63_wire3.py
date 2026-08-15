#!/usr/bin/env python3
"""Wire W63-A9: the 11B arg-emission row family (9 rows: MULDF3 x6, DIVDF3 x2,
ADDDF3 x1), the sprintf slot-fill row, and sprintf's no_split_addresses per-TU
flag (merged into the EXISTING jtbl_at_fusion entry -- dup-key discipline).
Justification: gcc-2.8.1 calls.c:1900 -- emission order IS argument-list order;
retail arg4-first is source-unreachable. All probe-verified 2x by A9."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


src = open('tools/build.py', encoding='utf-8', newline='').read()

# --- PER_TU_FLAGS: merge no_split_addresses into SPRINTF's existing entry ---
old = '"recon/syslib/psx/libc/SPRINTF.c":      {"jtbl_at_fusion": True},  # sprintf'
new = ('"recon/syslib/psx/libc/SPRINTF.c":      {"jtbl_at_fusion": True,  # sprintf\n'
       '        # w63-a9: nosplit hold RETIRED -- count-parity objection satisfied\n'
       '        # by the slot-fill row below (44 @545/545, was 56).\n'
       '                                             "no_split_addresses": True},')
assert src.count(old) == 1
src = src.replace(old, new)

# --- PER_FN_TEXT_MOVES: new entries ---
tm = src.find('PER_FN_TEXT_MOVES = {')
tm_end = src.find('\n}', tm)
anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
assert src.count(anchor) == 1

spec = json.load(open('scratchpad/w63a9/TEXT_MOVES_SPEC.json'))
note = {
    'recon/syslib/psx/libmath/MULDF3.c': '11B rows: muldf3 12->4, _mul_mant_d 14->10',
    'recon/syslib/psx/libmath/DIVDF3.c': '11B rows: divdf3 22->18',
    'recon/syslib/psx/libmath/ADDDF3.c': '11B row: adddf3 12->10',
    'recon/syslib/psx/libc/SPRINTF.c': 'slot-fill on the printHex digit-table j: '
                                       '56->44 @545/545 (kills the nosplit +1 nop)',
}
for rel, fns in spec.items():
    key = '"%s": {' % rel
    assert src.find(key, tm, tm_end) < 0, 'entry exists: ' + rel
    block = ('    # w63-a9 (probe-verified 2x; calls.c:1900 emission-order law):\n'
             '    # %s\n' % note[rel])
    block += '    "%s": {\n' % rel
    for fn, moves in fns.items():
        block += '        "%s": [\n' % fn
        for mv in moves:
            parts = ', '.join(
                '"%s": %s' % (k, lit(v)) if isinstance(v, str)
                else '"%s": %s' % (k, v) for k, v in mv.items())
            block += '            {%s},\n' % parts
        block += '        ],\n'
    block += '    },\n'
    src = src.replace(anchor, block + anchor)

ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses:', list(spec))

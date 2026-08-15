#!/usr/bin/env python3
"""Wire W64-A9: REPLACE the three libmath TU entries in PER_FN_TEXT_MOVES with
the full row lists from scratchpad/w64a9/TEXT_MOVES_SPEC.json.
build.py has MIXED line endings (LF entries inside CRLF file) -- all scanning
is LF-based with optional-\\r tolerance."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


spec = json.load(open('scratchpad/w64a9/TEXT_MOVES_SPEC.json'))
src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')

for rel in list(spec):
    tm_end = src.find('\n}', tm)
    key = '"%s": {' % rel
    i = src.find(key, tm, tm_end)
    assert i > 0, rel
    # back up over the contiguous comment block above the entry
    start = src.rfind('\n', 0, i) + 1
    while True:
        prev = src.rfind('\n', 0, start - 1) + 1
        line = src[prev:start].strip('\r\n')
        if line.strip().startswith('#'):
            start = prev
        else:
            break
    end = src.find('\n    },', i)
    assert 0 < end < tm_end, rel
    end += len('\n    },')
    while src[end:end + 1] in ('\r', '\n'):
        end += 1
    src = src[:start] + src[end:]

anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
assert src.count(anchor) == 1
block = ''
for rel, fns in spec.items():
    block += ('    # w63-a9 + w64-a9 (probe-verified 2x, objdump-verified per 15D):\n'
              '    # 11B rows + w64 relocations (muldf3 PASS/REAL=0; _mul_mant_d 8;\n'
              '    # divdf3 16 [11B fires at a _dbl_shift site too]; adddf3 8).\n')
    block += '    "%s": {\n' % rel
    for fn, rows in fns.items():
        block += '        "%s": [\n' % fn
        for mv in rows:
            parts = ', '.join(
                '"%s": %s' % (k, lit(v)) if isinstance(v, str)
                else '"%s": %s' % (k, v) for k, v in mv.items())
            block += '            {%s},\n' % parts
        block += '        ],\n'
    block += '    },\n'
src = src.replace(anchor, block + anchor)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('replaced 3 entries + parses')

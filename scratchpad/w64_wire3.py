#!/usr/bin/env python3
"""Wire W64-A11's Physics_Real row (6->4, probed 2x, anchors unique+pinned)."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


spec = json.load(open('scratchpad/w64a11/tm_physicsreal_spec.json'))
rows = spec['recon/game/common/physics.cpp']['Physics_Real__FP8Car_tObj']

src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
key = '"recon/game/common/physics.cpp": {'
i = src.find(key, tm)
anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
body = ('        # w64-a11 (probed 2x; cross-validated vs a source experiment that\n'
        '        # reproduces the load order but pays the seat): Physics_Real 6 -> 4.\n'
        '        "Physics_Real__FP8Car_tObj": [\n')
for mv in rows:
    parts = ', '.join('"%s": %s' % (k, lit(v)) for k, v in mv.items())
    body += '            {%s},\n' % parts
body += '        ],\n'
if i > 0:
    end = src.find('\n    },', i)
    assert '"Physics_Real' not in src[i:end]
    j = src.find('\n', i) + 1
    src = src[:j] + body + src[j:]
else:
    assert src.count(anchor) == 1
    src = src.replace(anchor, '    "recon/game/common/physics.cpp": {\n' + body + '    },\n' + anchor)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses (entry existed: %s)' % (i > 0))

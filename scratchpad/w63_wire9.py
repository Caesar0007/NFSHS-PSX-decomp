#!/usr/bin/env python3
"""Wire W63-A11's 4-row HeliCam spec (probe-verified 2x per stage: 12->10->7->3
->PASS 443/443; label-move + multi-line drop_after un-wrap generalisations)."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


spec = json.load(open('scratchpad/w63a11/tm_helicam_spec.json'))
rows = spec['recon/game/common/camera.cpp']['Camera_UpdateHeliCam__Fii']

src = open('tools/build.py', encoding='utf-8', newline='').read()
NL = '\r\n' if '\r\n' in src[:2000] else '\n'
tm = src.find('PER_FN_TEXT_MOVES = {')
tm_end = src.find(NL + '}', tm)
key = '"recon/game/common/camera.cpp": {'
i = src.find(key, tm, tm_end)
comment = ('        # w63-a11 (probe-verified 2x each stage, 12->10->7->3->PASS' + NL +
           '        # 443/443): HeliCam reorg target-steal undone -- rows 1-2 move' + NL +
           '        # the lui/li, rows 3-4 move LABELS and un-wrap .set noreorder' + NL +
           '        # blocks so maspsx supplies the empty slot itself. Production:' + NL +
           '        # shim-masked class (14A).' + NL)
body = comment + '        "Camera_UpdateHeliCam__Fii": [' + NL
for mv in rows:
    parts = ', '.join('"%s": %s' % (k, lit(v)) for k, v in mv.items())
    body += '            {%s},' % parts + NL
body += '        ],' + NL
if i > 0:
    entry_end = src.find(NL + '    },', i)
    assert '"Camera_UpdateHeliCam__Fii"' not in src[i:entry_end]
    j = src.find(NL, i) + len(NL)
    src = src[:j] + body + src[j:]
else:
    anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
    assert src.count(anchor) == 1
    src = src.replace(anchor, '    "recon/game/common/camera.cpp": {' + NL + body + '    },' + NL + anchor)
ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses (entry existed: %s)' % (i > 0))

#!/usr/bin/env python3
"""Wire W64-A13's two rows: Night_SetEnviroment -> PASS 68/68 (strict_branch
clean, semantics hand-verified) and Weather_DoWeather -> 4 count-exact."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
assert src.count(anchor) == 1

for jf, note in (('scratchpad/w64a13/tm_night.json',
                  'SetEnviroment 2 -> PASS 68/68 (moved lw crosses only li $3,128)'),
                 ('scratchpad/w64a13/tm_weather.json',
                  'DoWeather 6 -> 4 count-exact 197/197')):
    spec = json.load(open(jf))
    for rel, fns in spec.items():
        key = '"%s": {' % rel
        i = src.find(key, tm)
        body = ''
        for fn, rows in fns.items():
            body += '        # w64-a13 (probe-verified 2x + no-row control): %s\n' % note
            body += '        "%s": [\n' % fn
            for mv in rows:
                parts = ', '.join('"%s": %s' % (k, lit(v)) for k, v in mv.items())
                body += '            {%s},\n' % parts
            body += '        ],\n'
        if i > 0:
            end = src.find('\n    },', i)
            for fn in fns:
                assert ('"%s"' % fn) not in src[i:end], fn
            j = src.find('\n', i) + 1
            src = src[:j] + body + src[j:]
        else:
            src = src.replace(anchor, '    "%s": {\n' % rel + body + '    },\n' + anchor)

ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired + parses')

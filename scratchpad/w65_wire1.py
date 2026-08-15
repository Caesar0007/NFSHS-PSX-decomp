#!/usr/bin/env python3
"""Wire W65-A2's 10 label-move rows (append to existing fn lists or create
entries). All probed 2x with the FINAL-list probe file + objdump-verified.
LF-based scanning (build.py is CRLF-mixed)."""
import ast
import json


def lit(s):
    return '"' + s.encode('unicode_escape').decode().replace('"', '\\"') + '"'


spec = json.load(open('scratchpad/w65a2/SPEC_text_moves_w65a2_ALL.json'))
src = open('tools/build.py', encoding='utf-8', newline='').read()
tm = src.find('PER_FN_TEXT_MOVES = {')
anchor = '    # w60-a3 (orchestrator-wired, probe-verified REAL=0 in scratchpad/w60a3):'
assert src.count(anchor) == 1

for rel, fns in spec.items():
    if rel.startswith('_'):
        continue
    for fn, rows in fns.items():
        body = ''
        for mv in rows:
            parts = ', '.join('"%s": %s' % (k, lit(v)) for k, v in mv.items())
            body += '            {%s},\n' % parts
        tm_end = src.find('\n}', tm)
        key = '"%s": {' % rel
        i = src.find(key, tm, tm_end)
        if i > 0:
            entry_end = src.find('\n    },', i)
            j = src.find('"%s"' % fn, i, entry_end)
            if j > 0:
                # append into the existing fn list
                lst_open = src.find('[', j)
                depth, k = 0, lst_open
                while True:
                    c = src[k]
                    if c == '[':
                        depth += 1
                    elif c == ']':
                        depth -= 1
                        if depth == 0:
                            break
                    k += 1
                ins = src.rfind('\n', 0, k) + 1
                block = ('            # w65-a2 label-move (probed 2x, objdump 15D).\n' + body)
                src = src[:ins] + block + src[ins:]
            else:
                jj = src.find('\n', i) + 1
                block = ('        # w65-a2 label-move (probed 2x, objdump 15D).\n'
                         '        "%s": [\n' % fn + body + '        ],\n')
                src = src[:jj] + block + src[jj:]
        else:
            block = ('    # w65-a2 label-move rows (probed 2x, objdump 15D).\n'
                     '    "%s": {\n        "%s": [\n' % (rel, fn) + body +
                     '        ],\n    },\n')
            src = src.replace(anchor, block + anchor)

ast.parse(src)
open('tools/build.py', 'w', encoding='utf-8', newline='').write(src)
print('wired all rows + parses')

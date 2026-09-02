#!/usr/bin/env python3
r"""Coarse bisect: where does the phantom 16-byte stack temp come from?"""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
nv = (base / 'isoNV.c').read_text(encoding='utf-8', errors='surrogateescape')
L = nv.split('\n')


def find(sub, start=0):
    for i in range(start, len(L)):
        if sub in L[i]:
            return i
    raise SystemExit('not found: ' + sub)


out_lbl = find('out:')
end_fn = find('^}') if False else None
# function end = the line '}' at column 0 after out_lbl
for i in range(out_lbl, len(L)):
    if L[i] == '}':
        end_fn = i
        break

v = {}
# T1: replace whole tail after `out:` with `return 0;`
o = list(L)
o[out_lbl + 1:end_fn] = ['    return 0;']
v['T1_no_tail'] = '\n'.join(o)

# T2: replace the whole path-split for-loop body with nothing (keep tail)
for_i = find('for (; i < 8; i++)')
o = list(L)
o[for_i:out_lbl] = ['    i = 0;']
v['T2_no_loop'] = '\n'.join(o)

# T3: keep loop, drop only the inner do-while
do_i = find('do {', for_i)
# find the matching `} while (*s != sep2);`
end_do = find('} while (*s != sep2);', do_i)
o = list(L)
o[do_i - 1:end_do + 2] = []          # also drops the `if (*s != sep) {`/`}` wrapper lines
v['T3_no_dowhile'] = '\n'.join(o)

for k, s in v.items():
    (base / ('iso_' + k + '.c')).write_text(s, encoding='utf-8', errors='surrogateescape')
    print(k)

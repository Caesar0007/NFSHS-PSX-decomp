#!/usr/bin/env python3
r"""Fine bisect inside the do-while for the phantom 16-byte stack temp."""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
nv = (base / 'isoNV.c').read_text(encoding='utf-8', errors='surrogateescape')
L = nv.split('\n')


def find(sub, start=0):
    for i in range(start, len(L)):
        if sub in L[i]:
            return i
    raise SystemExit('not found: ' + sub)


i_do = find('do {')
i_store = find('*q = ch;', i_do)
i_read = find('ch = *(unsigned char *)s;', i_do)
i_test = find('if (!ch)', i_do)
i_ch0 = find('ch = *(unsigned char *)s;')

v = {}


def drop(idx, name):
    o = list(L)
    o[idx] = ''
    v[name] = '\n'.join(o)


drop(i_store, 'T4_no_store')
drop(i_read, 'T5_no_inloop_read')
drop(i_test, 'T6_no_zerotest')

# T7: the outer (pre-loop) read only, loop reads via *s directly
o = list(L)
o[i_store] = '                *q = (signed char)*(unsigned char *)s;'
v['T7_store_direct'] = '\n'.join(o)

# T8: `ch` never assigned outside the loop (move first read into the loop head)
o = list(L)
o[i_ch0] = ''
v['T8_no_preread'] = '\n'.join(o)

for k, s in v.items():
    assert s != nv, k
    (base / ('iso_' + k + '.c')).write_text(s, encoding='utf-8', errors='surrogateescape')
    print(k)

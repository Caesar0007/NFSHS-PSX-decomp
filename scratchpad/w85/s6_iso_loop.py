#!/usr/bin/env python3
r"""Try loop spellings of the CdSearchFile component copy that avoid the phantom
16-byte stack temp WITHOUT volatile."""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
nv = (base / 'isoNV.c').read_text(encoding='utf-8', errors='surrogateescape')
L = nv.split('\n')


def find(sub, start=0):
    for i in range(start, len(L)):
        if sub in L[i]:
            return i
    raise SystemExit('not found: ' + sub)


i_ch0 = find('ch = *(unsigned char *)s;')          # first (pre-loop) read
i_do = find('do {', i_ch0)
i_ch1 = find('ch = *(unsigned char *)s;', i_do)     # in-loop read
i_end = find('} while (*s != sep2);', i_do)

v = {}

# L1: `ch` declared int
v['L1_ch_int'] = nv.replace('    unsigned char  ch;', '    int            ch;')

# L2: read through a separate unsigned cursor kept in sync
o = list(L)
o[i_ch0] = '        ch = ((unsigned char *)s)[0];'
o[i_ch1] = '                ch = ((unsigned char *)s)[0];'
v['L2_index0'] = '\n'.join(o)

# L3: `*q = ch` written as `*q = *s;` (single read for the store, ch only for the test)
o = list(L)
o[find('*q = ch;', i_do)] = '                *q = (signed char)ch;'
v['L3_store_cast'] = '\n'.join(o)

# L4: while-loop rotation instead of do-while
o = list(L)
o[i_do] = '            while (1) {'
o[i_end] = '                if (*s == sep2) break;'
o.insert(i_end + 1, '            }')
v['L4_while1'] = '\n'.join(o)

# L5: `q` as `char *` rather than `signed char *`
v['L5_q_char'] = nv.replace('    signed char   *q;', '    char          *q;').replace(
    'q = (signed char *)comp;', 'q = comp;')

# L6: `s` as plain `char *` (still lb because char is... ccpsx char is UNSIGNED -> lbu; keep signed)
v['L6_ch_uchar_deref'] = nv.replace('ch = *(unsigned char *)s;', 'ch = (unsigned char)(*s);')

for k, s in v.items():
    assert s != nv, k
    (base / ('iso_' + k + '.c')).write_text(s, encoding='utf-8', errors='surrogateescape')
    print(k)

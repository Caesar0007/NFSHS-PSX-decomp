#!/usr/bin/env python3
r"""goto/loop-shape variants for the phantom 16-byte slot (uchar ch lane)."""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
nv = (base / 'isoNV.c').read_text(encoding='utf-8', errors='surrogateescape')
L = nv.split('\n')


def find(sub, start=0):
    for i in range(start, len(L)):
        if sub in L[i]:
            return i
    raise SystemExit('not found: ' + sub)


i_test = find('if (!ch)')
i_goto = i_test + 1                      # `goto out;` line
i_do = find('do {')
i_end = find('} while (*s != sep2);')
i_out = find('out:')

v = {}

# G1: goto a fresh label placed immediately before `out:`
o = list(L)
o[i_goto] = '                    goto brk;'
o.insert(i_out, 'brk:')
v['G1_own_label'] = '\n'.join(o)

# G2: hoist the zero-test to the while condition + a post-loop goto
o = list(L)
o[i_test] = ''
o[i_goto] = ''
o[i_end] = '            } while (ch && *s != sep2);'
o.insert(i_end + 1, '            if (!ch) goto out;')
v['G2_cond_hoist'] = '\n'.join(o)

# G3: the test written as a comparison against a char constant
o = list(L)
o[i_test] = "                if (ch == '\\0')"
v['G3_eqzero'] = '\n'.join(o)

# G4: goto replaced by a break out of BOTH loops via the for-condition (i = 8 sentinel)
o = list(L)
o[i_test] = '                if (!ch) {'
o[i_goto] = '                    q = q; goto out; }'
v['G4_braced'] = '\n'.join(o)

for k, s in v.items():
    assert s != nv, k
    (base / ('iso_' + k + '.c')).write_text(s, encoding='utf-8', errors='surrogateescape')
    print(k)

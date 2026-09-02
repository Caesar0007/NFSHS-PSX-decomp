#!/usr/bin/env python3
r"""Pointer-typing variants: put the cast on the SIGNED side instead."""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
nv = (base / 'isoNV.c').read_text(encoding='utf-8', errors='surrogateescape')

v = {}

# P1: s is `unsigned char *`; ch = *s (native), the separator tests go through
#     an explicit signed-char pun.
p1 = nv.replace('    signed char   *s;', '    unsigned char *s;')
p1 = p1.replace('s = (signed char *)name;', 's = (unsigned char *)name;')
p1 = p1.replace('ch = *(unsigned char *)s;', 'ch = *s;')
p1 = p1.replace('if (*s != sep) {', 'if (*(signed char *)s != sep) {')
p1 = p1.replace('} while (*s != sep2);', '} while (*(signed char *)s != sep2);')
p1 = p1.replace('if (!*s)\n            break;', 'if (!*(signed char *)s)\n            break;')
v['P1_unsigned_cursor'] = p1

# P2: same but the whole `ch` chain uses `s[0]`
p2 = p1.replace('ch = *s;', 'ch = s[0];')
v['P2_unsigned_cursor_idx'] = p2

for k, s in v.items():
    assert s != nv, k
    (base / ('iso_' + k + '.c')).write_text(s, encoding='utf-8', errors='surrogateescape')
    print(k)

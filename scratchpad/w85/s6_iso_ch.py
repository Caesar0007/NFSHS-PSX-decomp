#!/usr/bin/env python3
r"""Type/spelling spread for `ch` in CdSearchFile (non-volatile lane)."""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
nv = (base / 'isoNV.c').read_text(encoding='utf-8', errors='surrogateescape')
DECL = '    unsigned char  ch;'
assert DECL in nv

v = {}
v['C1_uint'] = nv.replace(DECL, '    unsigned int   ch;')
v['C2_reg_uchar'] = nv.replace(DECL, '    register unsigned char ch;')
v['C3_ushort'] = nv.replace(DECL, '    unsigned short ch;')
v['C4_schar'] = nv.replace(DECL, '    signed char    ch;')
v['C5_char'] = nv.replace(DECL, '    char           ch;')
# int ch, but force two loads by reading the test operand through a distinct expression
v['C6_int_plus_uchar_store'] = nv.replace(DECL, '    int            ch;').replace(
    '*q = ch;', '*q = (signed char)(unsigned char)ch;')
# uchar ch declared at BLOCK scope inside the for body
v['C7_blockscope'] = nv.replace(DECL, '').replace(
    '        ch = *(unsigned char *)s;', '        unsigned char ch = *(unsigned char *)s;', 1)

for k, s in v.items():
    assert s != nv, k
    (base / ('iso_' + k + '.c')).write_text(s, encoding='utf-8', errors='surrogateescape')
    print(k)

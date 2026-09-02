#!/usr/bin/env python3
r"""Bisect the phantom 16-byte stack temp in CdSearchFile (iso9660.c).

Writes variants of the NON-volatile source into scratchpad/w85/tmp/.
"""
import pathlib

base = pathlib.Path('scratchpad/w85/tmp')
src = (base / 'iso_orig.c').read_text(encoding='utf-8', errors='surrogateescape')
nv = src.replace('*(volatile unsigned char *)s', '*(unsigned char *)s')
assert nv != src
(base / 'isoNV.c').write_text(nv, encoding='utf-8', errors='surrogateescape')

L = nv.split('\n')


def repl(idx, text):
    out = list(L)
    out[idx] = text
    return '\n'.join(out)


def find(sub, start=0):
    for i in range(start, len(L)):
        if sub in L[i]:
            return i
    raise SystemExit('not found: ' + sub)


variants = {}
variants['A_nosearchprintf'] = repl(find('CdSearchFile: searching'), '')
variants['B_no_cmp'] = repl(find('if (_cmp(file[i].name, comp)) {'),
                            '        if (file[i].name[0] == comp[0]) {')
variants['C_nonotfound'] = repl(find('%s: not found', find('return 0;')), '')
variants['D_nopathlevel'] = repl(find('path level (%d) error'), '')
variants['E_nodirnotfound'] = repl(find('dir was not found'), '')
variants['F_searchdir_noarg'] = repl(find('dir = CD_searchdir(dir, comp);'),
                                     '        dir = CD_searchdir(dir, 0);')
variants['G_nostructcopy'] = repl(find('*fp = file[i];'), '')
variants['H_comp_static'] = nv.replace('    char           comp[0x20];',
                                       '    static char    comp[0x20];')

for k, v in variants.items():
    assert v != nv, k
    (base / ('iso_' + k + '.c')).write_text(v, encoding='utf-8', errors='surrogateescape')
print('\n'.join(sorted(variants)))

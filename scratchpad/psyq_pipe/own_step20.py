"""Blob ownership step 20 (2026-09-19) -- mdec.obj .data, retail 0x80052B28..0x80052B34 (end of front.data).
Evidence: (1) static xrefs + runtime trace: only mdec.cpp touches gMDECinfo / g_mdecdrawsyncfailed (initmdec, restoremdec,
mdecreset, mdec, mdecdone, MDECCompleteHandler); (2) the SYM defines g_mdecdrawsyncfailed (EXT INT) inside mdec.obj's
FILE record; (3) link order: mdec follows memcard, and the cell follows memcard's .data.
Zero in the image => explicit zero initializers (.data).  Resident frontend/psx object => -G0 like movie/psxfront/memcard,
which is what makes the accesses absolute (the unsized-array extern view is no longer needed).
NOT applied: `loadfilecallback` 0x8013DD60 -- nsync is its only USER, but the small-data tail is laid out in link order
and nsync (#163) would sit at 0x8013DC30; the cell comes after threads (#330), so another (data-only) object owns it."""
import json
import sys

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
ARRAY = '--array' in sys.argv     # fallback: keep the [1] array spelling if the scalar changes codegen


def edit(f, pairs):
    s = open(R + f, encoding='utf-8').read()
    for a, b in pairs:
        assert s.count(a) == 1, (f, a[:70], s.count(a))
        s = s.replace(a, b)
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


edit('recon/frontend/psx/mdec.h', [
    ('/* Retail mdec.obj emits this as an anonymous 8-byte STRTAG, with no typedef. */' + NL +
     'extern struct {' + NL + '    int numhandles;' + NL + '    int hDecode;' + NL +
     '} gMDECinfo;                             /* 0x80052b28 */' + NL +
     'extern int         g_mdecdrawsyncfailed[]; /* 0x80052b30 */' + NL,
     '/* gMDECinfo (0x80052b28) and g_mdecdrawsyncfailed (0x80052b30) are DEFINED in mdec.cpp: the struct is an anonymous' + NL +
     ' * 8-byte STRTAG with no typedef in the retail SYM, so it cannot be redeclared from a header. */' + NL),
])
flag = ('int g_mdecdrawsyncfailed[1] = { 0 };          /* 0x80052b30 (SYM: EXT INT; array spelling kept for codegen) */' if ARRAY
        else 'int g_mdecdrawsyncfailed = 0;                 /* 0x80052b30 (SYM: EXT INT) */')
edit('recon/frontend/psx/mdec.cpp', [
    ('#include "mdec.h"' + NL,
     '#include "mdec.h"' + NL + NL +
     '/* mdec.obj .data (retail 0x80052B28, the last object data of front.data), owned here since 2026-09-19.' + NL +
     ' * Retail emits the struct as an anonymous 8-byte STRTAG with no typedef.  Zero in the image => explicit initializers. */' + NL +
     'struct {' + NL + '    int numhandles;' + NL + '    int hDecode;' + NL + '} gMDECinfo = { 0, 0 };                    /* 0x80052b28 */' + NL +
     flag + NL),
] + ([] if ARRAY else [('    g_mdecdrawsyncfailed[0] = 1;', '    g_mdecdrawsyncfailed = 1;')]))

f = R + 'tools/build.py'
s = open(f, encoding='utf-8').read()
a = '    "recon/frontend/psx/memcard.c":        {"g_value": "0"},'
assert s.count(a) == 1
if '"recon/frontend/psx/mdec.cpp"' not in s:
    s = s.replace(a, a + NL + '    "recon/frontend/psx/mdec.cpp":         {"g_value": "0"},   # resident front object: gMDECinfo/g_mdecdrawsyncfailed are front.data @0x80052b28 (2026-09-19)')
    open(f, 'w', encoding='utf-8', newline='').write(s)

p = R + 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(p))
obj = 'build/recon/frontend/psx/mdec.cpp.o'
rows[:] = [r for r in rows if not (r['obj'] == obj and r['section'] == '.data')]
rows.append({'obj': obj, 'section': '.data', 'base': 0x80052B28, 'end': 0x80052B34, 'size': 12, 'ok': True,
             'unresolved': 0, 'words': 3, 'q': 0})
json.dump(rows, open(p, 'w'), indent=1)

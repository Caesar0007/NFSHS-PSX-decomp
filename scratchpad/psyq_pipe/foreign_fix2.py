"""foreign_fix2.py -- reconstructed .bss sections that had NO retail base and sat in the catch-all (on top of other
objects' addresses).  Retail homes by link order + PsyQ 4.3 object sizes (scratchpad/psyq_pipe/bss_holes.py, sdk_bss.py):
  * game copspeak.cpp .bss 0x10  = the retail label Copspeak_gTimeString.308 @0x8013E0B0 (ours is numbered .106);
  * libapi PAD.obj .bss 0x10     = the 16-byte hole 0x80148AB4 between libpad WAITRC2.obj and libcard PATCH.obj;
  * libapi CHCLRPAD.obj .bss 0x10 + libapi PATCH.obj .bss 0x10 = the last 32 bytes of .bss, 0x80148AE4 / 0x80148AF4,
    right after libcard END.obj -- the tail of the link order (END, ssine, CHCLRPAD, PATCH, A21, A18, A19, A20).
    Proof that the final link's dead stripping keeps a fully stripped member's .bss.
  * aih_btccop.cpp `static bool sayLose` is declared and never referenced; retail has no storage for it (SYM STAT record
    with the unrelocated value $4, the class of 15 such records) -> LINK_STRIPPED_BSS."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(p):
    return open(R + p, encoding='utf-8').read()


def wr(p, s):
    open(R + p, 'w', encoding='utf-8', newline='').write(s)


def sub1(s, a, b):
    assert s.count(a) == 1, a[:70]
    return s.replace(a, b)


p = 'linkers/nfs4_recon.bss_extra.json'
rows = json.load(open(R + p))
new = [('build/recon/game/common/copspeak.cpp.o', 0x8013E0B0, 0x10, 'retail label Copspeak_gTimeString.308 (function static, 16 B)'),
       ('build/recon/syslib/psx/libapi/PAD.c.o', 0x80148AB4, 0x10, 'link order: the 16-byte hole between libpad WAITRC2.obj [488] and libcard PATCH.obj [508] = PsyQ 4.3 libapi PAD.obj .bss 0x10'),
       ('build/recon/syslib/psx/libapi/CHCLRPAD.c.o', 0x80148AE4, 0x10, 'link order: .bss tail after libcard END.obj = CHCLRPAD.obj .bss 0x10 (fully link-stripped member keeps its .bss)'),
       ('build/recon/syslib/psx/libapi/PATCH.c.o', 0x80148AF4, 0x10, 'link order: last 16 bytes of .bss = libapi PATCH.obj .bss 0x10 (fully link-stripped member keeps its .bss)')]
for o, b, z, rec in new:
    assert not any(r['obj'] == o and r['section'] == '.bss' for r in rows), o
    rows.append({'obj': o, 'section': '.bss', 'base': b, 'end': b + z, 'size': z, 'ok': True, 'votes': 0, 'q': 0, 'record': '2026-09-20 ' + rec})
wr(p, json.dumps(rows, indent=1) + NL)

s = rd('recon/syslib/psx/libapi/CHCLRPAD.c')
s = sub1(s, " *   member's .bss is not removed by that stripping; its retail address is unknown (no label), so it is left to the" + NL + ' *   linker.',
         " *   member's .bss is not removed by that stripping: it is the 16 bytes at 0x80148AE4, right after libcard END.obj" + NL +
         ' *   (link order END, ssine, CHCLRPAD, PATCH = the last 32 bytes of .bss).')
s = sub1(s, 'long _chgclrpad_ra;   /* CHCLRPAD.obj .bss +0 : $ra parked across the BIOS calls */',
         'long _chgclrpad_bss[4];   /* CHCLRPAD.obj .bss (0x10 B) : +0 = $ra parked across the BIOS calls */')
s = s.replace('(_chgclrpad_ra)', '(_chgclrpad_bss)')
assert '_chgclrpad_ra' not in s
wr('recon/syslib/psx/libapi/CHCLRPAD.c', s)

s = rd('recon/syslib/psx/libapi/PATCH.c')
if 'retail address is unknown' in s:
    a = s.index(" *   member's .bss is not removed")
    b = s.index('linker.', a) + len('linker.')
    s = s[:a] + " *   member's .bss is not removed by that stripping: it is the LAST 16 bytes of .bss, 0x80148AF4 (link order END," + NL + ' *   ssine, CHCLRPAD, PATCH).' + s[b:]
    wr('recon/syslib/psx/libapi/PATCH.c', s)

s = rd('recon/link_stripped.h')
s = sub1(s, '/* A Sony HAND-ASSEMBLY routine the final link removed',
         '/* Uninitialised storage retail does not have: a static that is declared and never referenced (the SYM keeps its STAT' + NL +
         ' * record with an UNRELOCATED value, e.g. `sayLose` = $4) -- the final link allocates such cells per symbol and drops the' + NL +
         ' * unreferenced ones. */' + NL +
         '#define LINK_STRIPPED_BSS __attribute__((section(".bss.strip")))' + NL +
         '/* A Sony HAND-ASSEMBLY routine the final link removed')
wr('recon/link_stripped.h', s)

s = rd('recon/game/common/aih_btccop.cpp')
s = sub1(s, '  static bool sayLose;' + NL, '  static bool sayLose LINK_STRIPPED_BSS;   /* never referenced; retail has no storage for it (SYM STAT record value $4) */' + NL)
if 'link_stripped.h' not in s:
    i = s.index('#include')
    s = s[:i] + '#include "../../link_stripped.h"' + NL + s[i:]
wr('recon/game/common/aih_btccop.cpp', s)

s = rd('tools/gen_ld.py')
s = sub1(s, '    A("    /DISCARD/ : { *(.text.strip); *(.rodata.strip); }")', '    A("    /DISCARD/ : { *(.text.strip); *(.rodata.strip); *(.bss.strip); }")')
wr('tools/gen_ld.py', s)

s = rd('scratchpad/psyq_pipe/psylink_lane.py')
s = sub1(s, "if nm in (b'.text.strip', b'.rodata.strip'):", "if nm in (b'.text.strip', b'.rodata.strip', b'.bss.strip'):")
wr('scratchpad/psyq_pipe/psylink_lane.py', s)
print('ok')

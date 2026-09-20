"""own_by_linkorder4.py -- link-order owner fixes, pass 4 (2026-09-20).

 1. tmrsub[8] (0x8012360C) sits AFTER fixdsqrt.obj's table (link index 252) and spchrand.obj's seedX (260) and before libgpu
    SYS.obj (268): addtimer.obj (250) cannot own it.  vars.obj (267) -- the EA library's global-variables module -- does,
    together with the unowned vbltmrsub[8] right behind it.  (On the PC build tmrsub was a STATIC of inittmr.obj; on PSX
    addtimer.obj and inittmr.obj both use it, so it became a library global.)
 2. sndgs (.bss 0x80147860) sits between callback.obj (361) and salloc.obj (369): ssysinit.obj (285) cannot own it.
    sndpsxz.lib(sdata.obj) (365) is EA's sound-library DATA module (PC build: sdata.obj = 20 data globals, 0 functions).
 3. snddata.c is not a retail module.  Its cells go to their link-order owners: sndseed -> srandom.obj (484),
    sndpsxlimits[5] -> slimits.obj (237), the key-group counter -> stagpat.obj (379) together with the unowned
    snddefaultenvelope[8] right before it.
 4. sclcptch.c's sndcents[512] swallowed a COPY of snddefaultenvelope, the key-group counter, _ctype_ and the head of
    asintbl: the cents curve is 256 bytes."""
import json
import os
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)


def rd(p):
    return open(R + p, encoding='utf-8').read()


def wr(p, s):
    open(R + p, 'w', encoding='utf-8', newline='').write(s)


def sub1(s, a, b):
    assert s.count(a) == 1, a[:60]
    return s.replace(a, b)


# ---- 1. tmrsub / vbltmrsub -> vars.c
s = rd('recon/eaclib/psx/eacpsxz/addtimer.c')
a = s.index('/* owning-TU def (extern-declared, never defined; BSS) */')
b = s.index(NL, s.index('void (*tmrsub[8])(void) = { 0 };')) + 1
s = s[:a] + '/* tmrsub[8] is owned by vars.obj (vars.c): retail link order puts it after spchrand.obj, 17 modules past this one */' + NL + s[b:]
wr('recon/eaclib/psx/eacpsxz/addtimer.c', s)
s = rd('recon/eaclib/psx/eacpsxz/vars.c')
s = sub1(s, '#include "vars.h"' + NL, '#include "vars.h"' + NL + '#include "addtimer.h"' + NL + NL +
         '/* vars.obj .data 0x8012360C..0x8012364C (owner proven by retail link order, 2026-09-20: the block follows spchrand.obj\'s' + NL +
         ' * seedX [260] and precedes libgpu SYS.obj [268]; vars.obj is 267).  Zero but INITIALISED in the image.  vbltmrsub is' + NL +
         ' * referenced by no surviving function (its users were removed by the final link\'s dead stripping). */' + NL +
         'void (*tmrsub[8])(void) = { 0 };      /* @0x8012360C : timer callbacks (addtimer / deltimer / tmrint) */' + NL +
         'void (*vbltmrsub[8])(void) = { 0 };   /* @0x8012362C : vblank callbacks */' + NL)
wr('recon/eaclib/psx/eacpsxz/vars.c', s)

# ---- 2. sndgs -> sdata.c
s = rd('recon/eaclib/psx/sndpsxz/ssysinit.c')
a = s.index('__asm__("\\t.globl\\tsndgs\\n')
b = s.index(');', a) + 2
blk = s[a:b]
assert blk.count('.space') == 5, blk
s = s[:a] + '/* (2026-09-20) the run itself is defined by sdata.obj (sdata.c), its retail link-order owner */' + s[b:]
wr('recon/eaclib/psx/sndpsxz/ssysinit.c', s)
s = rd('recon/eaclib/psx/sndpsxz/sdata.c')
s = sub1(s, 'extern void iSNDpsxfree(int ptr);   /* sdmemman */' + NL,
         '/* sdata.obj .bss 0x80147860..0x80147914 : `sndgs`, the sound system\'s global state (180 B).  Owner proven by retail link' + NL +
         ' * order (2026-09-20): the run sits between callback.obj\'s mutexbuf [361] and salloc.obj\'s sndchanreserved [369], so' + NL +
         ' * ssysinit.obj [285] cannot own it; sdata.obj [365] is EA\'s sound-library DATA module (the PC build\'s sdata.obj is 20' + NL +
         ' * data globals and no function).  The interior labels are the views other TUs address directly (see ssysinit.c).' + NL +
         ' * OPEN: the slot 365..366 cannot tell whether iSNDplatformfree below is sdata.obj\'s or sdasync.obj\'s lone survivor. */' + NL +
         blk + NL + NL + 'extern void iSNDpsxfree(int ptr);   /* sdmemman */' + NL)
wr('recon/eaclib/psx/sndpsxz/sdata.c', s)

# ---- 3. snddata.c dissolved
s = rd('recon/eaclib/psx/sndpsxz/srandom.c')
s = sub1(s, 'extern unsigned int sndseed[6];' + NL,
         '/* srandom.obj .data 0x8013C2F0 (link-order owner, 2026-09-20; was in the non-module snddata.c): the additive PRNG state,' + NL +
         ' * same initial words as eacpsxz random.obj\'s `seed` and spchrand.obj\'s `seedX`. */' + NL +
         'unsigned int sndseed[6] = {' + NL + '    0xf22d0e56u, 0x883126e9u, 0xc624dd2fu,' + NL + '    0x0702c49cu, 0x9e353f7du, 0x6fdf3b64u' + NL + '};' + NL)
wr('recon/eaclib/psx/sndpsxz/srandom.c', s)
s = rd('recon/eaclib/psx/sndpsxz/slimits.c')
s = sub1(s, 'extern int sndpsxlimits[5];' + NL,
         '/* slimits.obj .data 0x801234D4 (link-order owner, 2026-09-20; was five scalars in the non-module snddata.c): the SPU' + NL +
         ' * memory / voice limit block; [4] = default SPU context size. */' + NL +
         'int sndpsxlimits[5] = { 0, 0, 0, 0, 0x2000 };' + NL)
wr('recon/eaclib/psx/sndpsxz/slimits.c', s)
s = rd('recon/eaclib/psx/sndpsxz/stagpat.c')
s = sub1(s, 'extern signed char  snddefaultenvelope;          /* default envelope table (sclcptch/data-mat) */' + NL,
         '/* stagpat.obj .data 0x801371C4..0x801371D0 (link-order slot sclcptch [378] .. CTYPE0 [389]; stagpat [379] is the only' + NL +
         ' * user of both cells): the default envelope, then the rolling key-group counter. */' + NL +
         'signed char snddefaultenvelope[8] = { -1, -1, -1, 0x7f, 0x7f, 0, 0, 0 };   /* @0x801371C4 */' + NL)
a = s.index('/* Five-byte extern view keeps this byte')
b = s.index(NL, s.index('extern unsigned char DAT_801371cc[5];')) + 1
s = s[:a] + 'unsigned char DAT_801371cc = 0;   /* @0x801371CC : rolling key-group counter (the library is built -G0: plain .data) */' + NL + s[b:]
s = s.replace('DAT_801371cc[0]', 'DAT_801371cc')
s = sub1(s, '    t[25] = (int)&snddefaultenvelope;' + NL + '    return (unsigned char *)&snddefaultenvelope;',
         '    t[25] = (int)snddefaultenvelope;' + NL + '    return (unsigned char *)snddefaultenvelope;')
a = s.index("    /* MATCH: DAT_801371cc's five-byte extern VIEW suppresses -G4")
b = s.index('*/', a) + 2
old = s[a:b]
s = s[:a] + '    /* MATCH: keeping `probe` distinct from `count` preserves the oracle\'s branch value in v1 and copies it to a2 for' + NL + '     * the loop bound. */' + s[b:]
wr('recon/eaclib/psx/sndpsxz/stagpat.c', s)
print('retired comment:', old[:80].replace(NL, ' '))
os.remove(R + 'recon/eaclib/psx/sndpsxz/snddata.c')

# ---- 4. sndcents is 256 bytes
s = rd('recon/eaclib/psx/sndpsxz/sclcptch.c')
a = s.index('unsigned char sndcents[512] = {')
b = s.index('};', a)
body = s[a:b]
vals = re.findall(r'0x[0-9a-fA-F]{2}', body[body.index(NL):])
assert len(vals) == 512, len(vals)
rows = [', '.join(vals[i:i + 16]) for i in range(0, 256, 16)]
s = (s[:a] + 'unsigned char sndcents[256] = {  /* @0x801370C4 : the 2^(x/256) cents curve.  (The old [512] spelling carried a COPY of' + NL +
     '                                   * stagpat.obj\'s snddefaultenvelope + key counter, libc _ctype_ and the head of asintbl.) */' + NL +
     ''.join('    ' + r + ',' + NL for r in rows).rstrip(',' + NL) + NL + s[b:])
wr('recon/eaclib/psx/sndpsxz/sclcptch.c', s)

# ---- placement rows
p = 'linkers/nfs4_recon.data_extra.json'
rows = json.load(open(R + p))
out = []
for r in rows:
    o = r['obj']
    if o.endswith('eacpsxz/addtimer.c.o') and r['section'] == '.data':
        r = dict(r, obj=o.replace('addtimer.c.o', 'vars.c.o'), end=r['base'] + 64, size=64, words=16)
    elif o.endswith('sndpsxz/snddata.c.o') and r['section'] == '.data':
        r = dict(r, obj=o.replace('snddata.c.o', 'srandom.c.o'))
    elif o.endswith('sndpsxz/snddata.c.o') and r['section'] == '.sdata':
        r = dict(r, obj=o.replace('snddata.c.o', 'slimits.c.o'), section='.data', end=r['base'] + 20, size=20, words=5)
    elif o.endswith('sndpsxz/sclcptch.c.o') and r['section'] == '.data':
        r = dict(r, end=r['base'] + 256, size=256, words=64)
    out.append(r)
assert not any(r['obj'].endswith('stagpat.c.o') and r['section'] == '.data' for r in out)
out.append({'obj': 'build/recon/eaclib/psx/sndpsxz/stagpat.c.o', 'section': '.data', 'base': 0x801371C4, 'end': 0x801371D0,
            'size': 12, 'ok': True, 'unresolved': 0, 'words': 3, 'q': 0})
open(R + p, 'w', encoding='utf-8', newline='').write(json.dumps(out, indent=1) + NL)
p = 'linkers/nfs4_recon.bss_extra.json'
rows = json.load(open(R + p))
n = 0
for r in rows:
    if r['obj'].endswith('sndpsxz/ssysinit.c.o') and r['section'] == '.bss':
        r['obj'] = r['obj'].replace('ssysinit.c.o', 'sdata.c.o'); n += 1
assert n == 1
open(R + p, 'w', encoding='utf-8', newline='').write(json.dumps(rows, indent=1) + NL)
p = 'linkers/nfs4_recon.data_8010CCD4.ldfrag'
s = rd(p)
s = sub1(s, 'build/recon/eaclib/psx/sndpsxz/snddata.c.o(.data);', 'build/recon/eaclib/psx/sndpsxz/srandom.c.o(.data);')
wr(p, s)
p = 'tools/build.py'
s = rd(p)
s = sub1(s, '    "recon/eaclib/psx/sndpsxz/sbdload.c":   {"no_strength_reduce": True},' + NL,
         '    "recon/eaclib/psx/sndpsxz/sbdload.c":   {"no_strength_reduce": True},' + NL +
         '    # 2026-09-20: stagpat.obj owns its one-byte key-group counter in plain .data (0x801371CC) -- the sndpsxz oracles' + NL +
         '    # carry zero %gp_rel sites (library built -G0, like spchpsxz); -G0 retires the five-byte extern-view device.' + NL +
         '    "recon/eaclib/psx/sndpsxz/stagpat.c":   {"g_value": 0},' + NL)
wr(p, s)
print('ok')

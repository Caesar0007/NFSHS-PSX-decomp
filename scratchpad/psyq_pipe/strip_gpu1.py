"""strip_gpu1.py -- libgpu SYS.obj, first batch of link-removed functions (PsyQ 4.3 sys.c 1.140 positions):
GetGraphDebug @628, GetDrawEnv @2936, GetDispEnv @4260, GetODE @4312, SetDrawOffset @4544, SetPriority @4608."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libgpu/SYS.c'
s = open(p, encoding='utf-8').read()


def before(marker, text):
    global s
    assert s.count(marker) == 1, marker
    s = s.replace(marker, text + NL + marker)


before('/* @0x800ED670 : initialise the graphics system for the given mode. */',
       '#include "../../../link_stripped.h"' + NL +
       '/* sys.c functions retail\'s final link removed as unreferenced (bytes: PsyQ 4.3 libgpu SYS.obj) */' + NL +
       'extern int   GetGraphDebug(void) LINK_STRIPPED;' + NL + 'extern void *GetDrawEnv(void *env) LINK_STRIPPED;' + NL +
       'extern void *GetDispEnv(void *env) LINK_STRIPPED;' + NL + 'extern int   GetODE(void) LINK_STRIPPED;' + NL +
       'extern void  SetDrawOffset(void *p, void *ofs) LINK_STRIPPED;' + NL + 'extern void  SetPriority(void *p, int pbc, int pbw) LINK_STRIPPED;' + NL)
before('static __inline__ void DrawSyncCallback(void (*func)(void))',
       '/* SYS.obj +628 (LINK-STRIPPED) : GetGraphDebug */' + NL + 'extern int GetGraphDebug(void) { return GEnv.debug; }' + NL)
before('extern void *PutDispEnv(void *env)' + NL + '{',
       '/* SYS.obj +2936 (LINK-STRIPPED) : GetDrawEnv -- copy out the cached DRAWENV */' + NL +
       'extern void *GetDrawEnv(void *env)' + NL + '{' + NL + '    _memcpy(env, GEnv.drawenv, 0x5c);' + NL + '    return env;' + NL + '}' + NL)
before('/* @0x800EE2DC : SetTexWindow(DR_TWIN *p, RECT *tw) */',
       '/* SYS.obj +4260 (LINK-STRIPPED) : GetDispEnv -- copy out the cached DISPENV */' + NL +
       'extern void *GetDispEnv(void *env)' + NL + '{' + NL + '    _memcpy(env, GEnv.dispenv, 0x14);' + NL + '    return env;' + NL + '}' + NL + NL +
       '/* SYS.obj +4312 (LINK-STRIPPED) : GetODE -- odd/even field flag = bit 31 of the GPU status */' + NL +
       'extern int GetODE(void) { return (u_long)GEnv_drv->get_status() >> 31; }' + NL)
before('/* @0x800EE394 : SetDrawStp(DR_STP *p, int pbw)',
       '/* SYS.obj +4544 (LINK-STRIPPED) : SetDrawOffset(DR_OFFSET *p, u_short *ofs) */' + NL +
       'extern void SetDrawOffset(void *p, void *ofs)' + NL + '{' + NL + '    ((char *)p)[3] = 2;' + NL +
       '    ((int *)p)[1] = (int)_set_draw_offset(((short *)ofs)[0], ((short *)ofs)[1]);' + NL + '    ((int *)p)[2] = 0;' + NL + '}' + NL + NL +
       '/* SYS.obj +4608 (LINK-STRIPPED) : SetPriority(DR_PRIO *p, int pbc, int pbw) -- GP0 0xE6 mask bits */' + NL +
       'extern void SetPriority(void *p, int pbc, int pbw)' + NL + '{' + NL + '    int data = 0xe6000000;' + NL + NL +
       '    ((char *)p)[3] = 2;' + NL + '    if (pbc) {' + NL + '        data |= 2;' + NL + '    }' + NL +
       '    ((int *)p)[1] = data | (pbw != 0);' + NL + '    ((int *)p)[2] = 0;' + NL + '}' + NL)
open(p, 'w', encoding='utf-8', newline='').write(s)

j = json.load(open(R + 'linkers/link_stripped.json'))
O = 'build/recon/syslib/psx/libgpu/SYS.c.o'
for fn, off, size in (('GetGraphDebug', 628, 16), ('GetDrawEnv', 2936, 52), ('GetDispEnv', 4260, 52), ('GetODE', 4312, 48),
                      ('SetDrawOffset', 4544, 64), ('SetPriority', 4608, 40)):
    j['functions'].append({'object': O, 'function': fn, 'sdk': 'LIBGPU/' + fn,
                           'evidence': 'PsyQ 4.3 libgpu SYS.obj (sys.c 1.140, same $Id as retail) @%d+%d; retail anchors (address - SDK offset) drop by exactly the unlabelled sizes across it' % (off, size)})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(j, indent=1) + NL)
print('ok')

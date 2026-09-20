"""strip_gpu2.py -- libgpu SYS.obj, second batch: the real owners of three 'dead literal' carriers + DrawPrim.
SetGraphDebug @372, SetGraphQueue @464, DrawSyncCallback @644, DrawPrim @2324 (PsyQ 4.3 sys.c 1.140)."""
import json
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libgpu/SYS.c'
s = open(p, encoding='utf-8').read()

# the three unused-inline carriers (and their lead comment) go
a = s.index('/* String-only survivors of UNUSED static inlines in the 1.140 source')
b = s.index('/* SYS.obj +628 (LINK-STRIPPED) : GetGraphDebug */')
s = s[:a] + (
    '/* SYS.obj +372 (LINK-STRIPPED) : SetGraphDebug -- set the debug level, return the old one.' + NL +
    ' * (GEnv._pad3 is the "reverse" flag this message prints.) */' + NL +
    'extern int SetGraphDebug(int level)' + NL + '{' + NL + '    u_char old = GEnv.debug;' + NL + NL + '    GEnv.debug = level;' + NL +
    '    if (GEnv.debug) {' + NL +
    '        GPU_printf("SetGraphDebug:level:%d,type:%d reverse:%d\\n", GEnv.debug, GEnv.mode, GEnv._pad3);   /* @0x80056D44 */' + NL +
    '    }' + NL + '    return old;' + NL + '}' + NL + NL +
    '/* SYS.obj +464 (LINK-STRIPPED) : SetGraphQueue -- switch the command-queue mode (GEnv.active), return the old one */' + NL +
    'extern int SetGraphQueue(int mode)' + NL + '{' + NL + '    u_char old = GEnv.active;' + NL + NL +
    '    if (GEnv.debug >= 2) {' + NL + '        GPU_printf("SetGrapQue(%d)...\\n", mode);    /* @0x80056D70 (retail\'s own typo) */' + NL + '    }' + NL +
    '    if (mode != GEnv.active) {' + NL + '        GEnv_drv->reset(1);' + NL + '        GEnv.active = mode;' + NL + '        DMACallback(2, 0);' + NL + '    }' + NL +
    '    return old;' + NL + '}' + NL + NL) + s[b:]
a = s.index('static __inline__ void DrawSyncCallback(void (*func)(void))')
b = s.index('}', a) + 2
s = s[:a] + (
    '/* SYS.obj +644 (LINK-STRIPPED) : DrawSyncCallback -- install the queue-drained callback, return the old one */' + NL +
    'extern void (*DrawSyncCallback(void (*func)()))()' + NL + '{' + NL + '    void (*old)();' + NL + NL +
    '    if (GEnv.debug >= 2) {' + NL + '        GPU_printf("DrawSyncCallback(%08x)...\\n", func);   /* @0x80056D84 */' + NL + '    }' + NL +
    '    old = GEnv.idle_cb;' + NL + '    GEnv.idle_cb = func;' + NL + '    return old;' + NL + '}' + NL) + s[b:]
m = re.search(r'^/\* @0x800EDCB4[^\n]*\n', s, re.M)
assert m, 'DrawOTag marker'
s = s[:m.start()] + (
    '/* SYS.obj +2324 (LINK-STRIPPED) : DrawPrim -- draw one primitive now */' + NL +
    'extern void DrawPrim(void *p)' + NL + '{' + NL + '    int len = ((u_char *)p)[3];' + NL + NL + '    GEnv_drv->sync(0);' + NL +
    '    GEnv_drv->send_gp0((u_long *)p + 1, len);' + NL + '}' + NL + NL) + s[m.start():]
x = 'extern int   GetGraphDebug(void) LINK_STRIPPED;'
assert s.count(x) == 1
s = s.replace(x, 'extern int   SetGraphDebug(int level) LINK_STRIPPED;' + NL + 'extern int   SetGraphQueue(int mode) LINK_STRIPPED;' + NL + x + NL +
              'extern void (*DrawSyncCallback(void (*func)()))() LINK_STRIPPED;' + NL + 'extern void  DrawPrim(void *p) LINK_STRIPPED;')
open(p, 'w', encoding='utf-8', newline='').write(s)

j = json.load(open(R + 'linkers/link_stripped.json'))
O = 'build/recon/syslib/psx/libgpu/SYS.c.o'
for fn, off, size in (('SetGraphDebug', 372, 92), ('SetGraphQueue', 464, 164), ('DrawSyncCallback', 644, 96), ('DrawPrim', 2324, 92)):
    j['functions'].append({'object': O, 'function': fn, 'sdk': 'LIBGPU/' + fn,
                           'evidence': 'PsyQ 4.3 libgpu SYS.obj (sys.c 1.140, same $Id as retail) @%d+%d; retail anchors drop by exactly the unlabelled sizes across it' % (off, size)})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(j, indent=1) + NL)
print('ok')

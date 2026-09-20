"""strip_gpu3.py -- libgpu SYS.obj, third batch: ClearImage2 @1424 and ClearOTag @1952 replace their literal carriers."""
import json

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libgpu/SYS.c'
s = open(p, encoding='utf-8').read()
a = s.index('/* Retail SYS.obj has NO ClearImage2 code but its .rdata carries "ClearImage2"')
b = s.index('/* @0x800EDA90 : LoadImage(RECT*, u_long *data) */')
s = s[:a] + (
    '/* SYS.obj +1424 (LINK-STRIPPED) : ClearImage2 -- ClearImage with bit 31 set in the colour word */' + NL +
    'extern int ClearImage2(void *rect, unsigned char r, unsigned char g, unsigned char b)' + NL + '{' + NL + '    int color;' + NL +
    '    _image("ClearImage2", rect);                 /* @0x80056df8 */' + NL +
    '    color = ((b & 0xff) << 16) | ((g & 0xff) << 8) | 0x80000000 | (r & 0xff);' + NL +
    '    return GEnv_drv->que_push(GEnv_drv->blit_clear, (u_long *)rect, 8, color);' + NL + '}' + NL + NL) + s[b:]
a = s.index('static __inline__ u_long *ClearOTag(u_long *ot, int n)')
b = s.index('}', a) + 2
s = s[:a] + (
    '/* SYS.obj +1952 (LINK-STRIPPED) : ClearOTag -- forward-linked ordering table, same terminator tail as ClearOTagR */' + NL +
    'extern u_long *ClearOTag(u_long *ot, int n)' + NL + '{' + NL +
    '    if (GEnv.debug >= 2)' + NL + '        GPU_printf("ClearOTag(%08x,%d)...\\n", ot, n);   /* @0x80056E24 */' + NL +
    '    while (--n) {' + NL + '        ((u_char *)ot)[3] = 0;' + NL +
    '        ot[0] = (ot[0] & 0xff000000u) | ((u_long)(long)(ot + 1) & 0x00ffffffu);' + NL + '        ot++;' + NL + '    }' + NL +
    '    {' + NL + '        u_long mask = 0x00ffffffu;' + NL + '        u_long *link = &_otc_link;' + NL +
    '        *link = 0x04000000u | ((u_long)(long)&_otc_term & mask);' + NL + '        ot[0] = (u_long)(long)link & mask;' + NL + '    }' + NL +
    '    return ot;' + NL + '}' + NL) + s[b:]
x = 'extern void  DrawPrim(void *p) LINK_STRIPPED;'
assert s.count(x) == 1
s = s.replace(x, x + NL + 'extern int   ClearImage2(void *rect, unsigned char r, unsigned char g, unsigned char b) LINK_STRIPPED;' + NL +
              'extern u_long *ClearOTag(u_long *ot, int n) LINK_STRIPPED;')
open(p, 'w', encoding='utf-8', newline='').write(s)
j = json.load(open(R + 'linkers/link_stripped.json'))
O = 'build/recon/syslib/psx/libgpu/SYS.c.o'
for fn, off, size in (('ClearImage2', 1424, 152), ('ClearOTag', 1952, 200)):
    j['functions'].append({'object': O, 'function': fn, 'sdk': 'LIBGPU/' + fn,
                           'evidence': 'PsyQ 4.3 libgpu SYS.obj (sys.c 1.140, same $Id as retail) @%d+%d; retail anchors drop by exactly the unlabelled sizes across it' % (off, size)})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(j, indent=1) + NL)
print('ok')

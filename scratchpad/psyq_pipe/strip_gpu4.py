"""strip_gpu4.py -- libgpu SYS.obj, fourth batch: DrawOTagEnv @2720, LoadImage2 @11172, StoreImage2 @11408."""
import json
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
p = R + 'recon/syslib/psx/libgpu/SYS.c'
s = open(p, encoding='utf-8').read()

a = s.index('static __inline__ void DrawOTagEnv(u_long *p, void *env)')
b = s.index('}', a) + 2
s = s[:a] + (
    '/* SYS.obj +2720 (LINK-STRIPPED) : DrawOTagEnv -- PutDrawEnv whose DR_ENV is linked in front of the table `ot` */' + NL +
    'extern void DrawOTagEnv(u_long *ot, void *env)' + NL + '{' + NL +
    '    u_long *src   = ot;' + NL + '    u_char *debug = &GEnv.debug;' + NL + '    void   *prim  = env;' + NL + '    u_long *tag;' + NL + NL +
    '    if (*debug >= 2)' + NL + '        GPU_printf("DrawOTagEnv(%08x,&08x)...\\n", src, prim);   /* @0x80056E90 (retail\'s own \'&08x\') */' + NL +
    '    tag = (u_long *)((u_char *)prim + 0x1c);' + NL + '    _set_drawenv(tag, prim);' + NL + '    {' + NL +
    '        u_long        word = (*tag & 0xff000000u) | ((u_long)(long)src & 0x00ffffffu);' + NL +
    '        const GpuTbl *gpu  = GEnv_drv;' + NL + NL + '        *tag = word;' + NL +
    '        gpu->que_push((QueFunc)gpu->dma_chain, tag, 0x40, 0);' + NL + '    }' + NL +
    '    _memcpy(debug + 0xE, prim, 0x5c);' + NL + '}' + NL) + s[b:]

a = s.index('static __inline__ int LoadImage2(void *rect, u_long *data)')
b = s.index('}', a) + 2
body = ('    _gpu_timeout_target = VSync(-1) + 0xF0;' + NL + '    _gpu_timeout_count = 0;' + NL +
        '    while ((*D2_CHCR & 0x01000000) != 0 || (*GPU_GP1 & 0x04000000) == 0) {' + NL +
        '        if (_gpu_check_timeout() != 0)' + NL + '            return -1;' + NL + '    }' + NL +
        '    DMACallback(2, (int)_install_drain_cb);' + NL)
s = s[:a] + (
    '/* SYS.obj +11172 (LINK-STRIPPED) : LoadImage2 -- unqueued LoadImage: wait for the GPU, then run the transfer now */' + NL +
    'extern int LoadImage2(void *rect, u_long *data)' + NL + '{' + NL +
    '    _image("LoadImage2", rect);                  /* @0x80056eec */' + NL + body +
    '    GEnv_drv->dws((u_long *)rect, (int)data);' + NL + '    return 0;' + NL + '}' + NL + NL +
    '/* SYS.obj +11408 (LINK-STRIPPED) : StoreImage2 */' + NL +
    'extern int StoreImage2(void *rect, u_long *data)' + NL + '{' + NL +
    '    _image("StoreImage2", rect);' + NL + body +
    '    GEnv_drv->drs((u_long *)rect, (int)data);' + NL + '    return 0;' + NL + '}' + NL) + s[b:]
x = 'extern u_long *ClearOTag(u_long *ot, int n) LINK_STRIPPED;'
assert s.count(x) == 1
s = s.replace(x, x + NL + 'extern void  DrawOTagEnv(u_long *ot, void *env) LINK_STRIPPED;' + NL +
              'extern int   LoadImage2(void *rect, u_long *data) LINK_STRIPPED;' + NL + 'extern int   StoreImage2(void *rect, u_long *data) LINK_STRIPPED;')
open(p, 'w', encoding='utf-8', newline='').write(s)
j = json.load(open(R + 'linkers/link_stripped.json'))
O = 'build/recon/syslib/psx/libgpu/SYS.c.o'
for fn, off, size in (('DrawOTagEnv', 2720, 216), ('LoadImage2', 11172, 236), ('StoreImage2', 11408, 236)):
    j['functions'].append({'object': O, 'function': fn, 'sdk': 'LIBGPU/' + fn,
                           'evidence': 'PsyQ 4.3 libgpu SYS.obj (sys.c 1.140, same $Id as retail) @%d+%d; retail anchors drop by exactly the unlabelled sizes across it' % (off, size)})
open(R + 'linkers/link_stripped.json', 'w', encoding='utf-8', newline='').write(json.dumps(j, indent=1) + NL)
print('ok')

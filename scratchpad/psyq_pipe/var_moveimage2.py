FILE = 'recon/syslib/psx/libgpu/SYS.c'
START = 'extern int MoveImage2(void *rect, int x, int y)\n{'
END = '\nextern int _gpu_init_videomode(int mode)'
HEAD = ('extern int MoveImage2(void *rect, int x, int y)\n{\n%s\n    _image("MoveImage2", rect);\n'
        '    _gpu_timeout_target = VSync(-1) + 0xF0;\n    _gpu_timeout_count = 0;\n'
        '    while ((*D2_CHCR & 0x01000000) != 0 || (*GPU_GP1 & 0x04000000) == 0) {\n        if (_gpu_check_timeout() != 0)\n            return -1;\n    }\n'
        '    DMACallback(2, (int)_install_drain_cb);\n'
        '    if (((short *)rect)[2] == 0 || ((short *)rect)[3] == 0)\n        return -1;\n')
TAIL = '}\n'
import re
src = open('C:/Temp/nfs4-decomp/' + FILE, encoding='utf-8').read()
a = src.index(START); b = src.index(END, a)
between = src[a:b]
k = between.rindex('}\n') + 2
KEEP = between[k:]          # whatever sits between the function's end and END (comments)
VARIANTS = [
    ('direct-stores', HEAD % '' +
     '    _move_prim[2] = *(u_long *)rect;\n    _move_prim[3] = (u_long)((y << 16) | (x & 0xffff));\n'
     '    _move_prim[4] = *((u_long *)rect + 1);\n    GEnv_drv->dma_chain(_move_prim);\n    return 0;\n' + TAIL + KEEP),
    ('dst-first-direct', HEAD % '' +
     '    _move_prim[3] = (u_long)((y << 16) | (x & 0xffff));\n    _move_prim[2] = *(u_long *)rect;\n'
     '    _move_prim[4] = *((u_long *)rect + 1);\n    GEnv_drv->dma_chain(_move_prim);\n    return 0;\n' + TAIL + KEEP),
    ('anchor-nofence', HEAD % '    u_long *p;\n    u_long srcxy;\n    GpuTbl *drv;\n' +
     '    p = &_move_prim[2];\n    srcxy = *(u_long *)rect;\n    drv = GEnv_drv;\n    p[0] = srcxy;\n'
     '    p[1] = (u_long)((y << 16) | (x & 0xffff));\n    p[2] = *((u_long *)rect + 1);\n    drv->dma_chain(p - 2);\n    return 0;\n' + TAIL + KEEP),
    ('anchor-fence', HEAD % '    u_long *p;\n    u_long srcxy;\n    GpuTbl *drv;\n' +
     '    p = &_move_prim[2];\n    srcxy = *(u_long *)rect;\n    drv = GEnv_drv;\n    p[0] = srcxy;\n'
     '    p[1] = (u_long)((y << 16) | (x & 0xffff));\n    __asm__("" : "=r"(p) : "0"(p));\n    p[2] = *((u_long *)rect + 1);\n    drv->dma_chain(p - 2);\n    return 0;\n' + TAIL + KEEP),
    ('dstxy-first-anchor', HEAD % '    u_long *p;\n    u_long dstxy;\n    u_long srcxy;\n    GpuTbl *drv;\n' +
     '    dstxy = (u_long)((y << 16) | (x & 0xffff));\n    srcxy = *(u_long *)rect;\n    drv = GEnv_drv;\n    p = &_move_prim[2];\n    p[1] = dstxy;\n    p[0] = srcxy;\n'
     '    p[2] = *((u_long *)rect + 1);\n    drv->dma_chain(p - 2);\n    return 0;\n' + TAIL + KEEP),
]

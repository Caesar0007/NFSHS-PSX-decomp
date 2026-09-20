FILE = 'recon/syslib/psx/libgpu/SYS.c'
START = 'extern int SetGraphQueue(int mode)\n{'
END = '/* SYS.obj +628 (LINK-STRIPPED) : GetGraphDebug */'
H = 'extern int SetGraphQueue(int mode)\n{\n'
P = '    if (GEnv.debug >= 2) {\n        GPU_printf("SetGrapQue(%d)...\\n", mode);    /* @0x80056D70 (retail\'s own typo) */\n    }\n'
T = '}\n\n'
VARIANTS = [
    ('old-after-printf-decl', H + '    int old;\n\n    old = GEnv.active;\n' + P +
     '    if (mode != GEnv.active) {\n        GEnv_drv->reset(1);\n        GEnv.active = mode;\n        DMACallback(2, 0);\n    }\n    return old;\n' + T),
    ('compare-swapped', H + '    int old = GEnv.active;\n\n' + P +
     '    if (GEnv.active != mode) {\n        GEnv_drv->reset(1);\n        GEnv.active = mode;\n        DMACallback(2, 0);\n    }\n    return old;\n' + T),
    ('early-return', H + '    int old = GEnv.active;\n\n' + P +
     '    if (mode == GEnv.active) {\n        return old;\n    }\n    GEnv_drv->reset(1);\n    GEnv.active = mode;\n    DMACallback(2, 0);\n    return old;\n' + T),
    ('printf-first-then-old', H + '    int old;\n\n' + P + '    old = GEnv.active;\n' +
     '    if (mode != old) {\n        GEnv_drv->reset(1);\n        GEnv.active = mode;\n        DMACallback(2, 0);\n    }\n    return old;\n' + T),
    ('store-then-callback-uchar-cmp', H + '    int old = GEnv.active;\n\n' + P +
     '    if ((u_char)mode != GEnv.active) {\n        GEnv_drv->reset(1);\n        GEnv.active = mode;\n        DMACallback(2, 0);\n    }\n    return old;\n' + T),
    ('register-mode-copy', H + '    int m = mode;\n    int old = GEnv.active;\n\n' + P.replace(', mode)', ', m)') +
     '    if (m != GEnv.active) {\n        GEnv_drv->reset(1);\n        GEnv.active = m;\n        DMACallback(2, 0);\n    }\n    return old;\n' + T),
]

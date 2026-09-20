FILE = 'recon/syslib/psx/libmcrd/LIBMCRD.c'
START = 'extern long MemCardOpen(long chan, char *file, long flag)\n{'
END = '/* LIBMCRD.obj +1852 (LINK-STRIPPED) : MemCardClose'
LIT = '"Access Denied. : file already open.\\n"'
HEAD = 'extern long MemCardOpen(long chan, char *file, long flag)\n{\n'
TAILLOOP = ('        MemCardSync(0, 0, &rslt);\n        MemCardCallback((int)_mc_save_cb);\n'
            '        if (rslt == 3)\n            continue;\n        if (rslt == 2) {\n            retry++;\n            if (retry < 5)\n                continue;\n        }\n'
            '        if (rslt == 0)\n            rslt = 5;\n        return rslt;\n    }\n}\n\n')


def v(decls, pre, openstmt, busy):
    return (HEAD + decls + '\n    retry = 0;\n    if (*pfd >= 0) {\n        printf(' + LIT + ');\n        return -1;\n    }\n' + pre +
            '    while (1) {\n        _clr_card_event();\n' + openstmt +
            '        _mc_save_cb = (int (*)(int, int))MemCardCallback(0);\n' + busy + TAILLOOP)


BUSY_MC = ('        if (mc.cmd > 0) {\n            printf("Access Denied. : event multiple open\\n");\n        } else {\n'
           '            mc.cmd = 2;\n            mc.rslt = 0;\n            mc.done = 0;\n            mc.chan = chan;\n            UserFuncOpen((int)MemCardCmd_cb);\n        }\n')
BUSY_P = ('        if (p[0] > 0) {\n            printf("Access Denied. : event multiple open\\n");\n        } else {\n'
          '            p[0] = 2;\n            p[1] = 0;\n            p[2] = 0;\n            mc.chan = chan;\n            UserFuncOpen((int)MemCardCmd_cb);\n        }\n')
VARIANTS = [
    ('locals-dev-p', v('    int  rslt;\n    int  retry;\n    int *pfd = &mc.fd;\n    char *dev;\n    int *p;\n',
                       '    dev = (char *)(pfd + 4);\n    MemCardMakeDevname(chan, dev);\n    strcat(dev, file);\n    pfd[-1] = chan;\n    p = pfd - 4;\n',
                       '        *pfd = open(dev, flag | 0x8000);\n        if (*pfd >= 0)\n            return 0;\n', BUSY_P)),
    ('locals-fd-var', v('    int  rslt;\n    int  retry;\n    int  fd;\n    int *pfd = &mc.fd;\n    char *dev;\n    int *p;\n',
                        '    dev = (char *)(pfd + 4);\n    MemCardMakeDevname(chan, dev);\n    strcat(dev, file);\n    pfd[-1] = chan;\n    p = pfd - 4;\n',
                        '        fd = open(dev, flag | 0x8000);\n        ((int *)dev)[-4] = fd;\n        if (fd >= 0)\n            return 0;\n', BUSY_P)),
    ('dev-local-mc-rest', v('    int  rslt;\n    int  retry;\n    int *pfd = &mc.fd;\n    char *dev;\n',
                            '    dev = (char *)(pfd + 4);\n    MemCardMakeDevname(chan, dev);\n    strcat(dev, file);\n    pfd[-1] = chan;\n',
                            '        mc.fd = open(dev, flag | 0x8000);\n        if (mc.fd >= 0)\n            return 0;\n', BUSY_MC)),
    ('mixed-sdk-bases', v('    int  rslt;\n    int  retry;\n    int  fd;\n    int *pfd = &mc.fd;\n    char *dev;\n    int *p;\n',
                          '    dev = (char *)(pfd + 4);\n    MemCardMakeDevname(chan, dev);\n    strcat(dev, file);\n    pfd[-1] = chan;\n    p = pfd - 4;\n',
                          '        fd = open(dev, flag | 0x8000);\n        ((int *)dev)[-4] = fd;\n        if (fd >= 0)\n            return 0;\n',
                          '        if (((int *)dev)[-8] > 0) {\n            printf("Access Denied. : event multiple open\\n");\n        } else {\n'
                          '            ((int *)dev)[-8] = 2;\n            p[1] = 0;\n            p[2] = 0;\n            mc.chan = chan;\n            UserFuncOpen((int)MemCardCmd_cb);\n        }\n')),
]

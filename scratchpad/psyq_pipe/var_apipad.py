import sys
FILE = 'recon/syslib/psx/libapi/PAD.c'
WHICH = sys.argv[1] if False else None
src = open('C:/Temp/nfs4-decomp/' + FILE, encoding='utf-8').read()
# this file drives ONE function per run: set by the presence of the env var
import os
fn = os.environ.get('VAR_FN', '_pad_intr_verify')
if fn == '_pad_intr_verify':
    START = 'static int _pad_intr_verify(void)\n{'
    END = '\x00END'
    H = 'static int _pad_intr_verify(void)\n{\n'
    VARIANTS = [
        ('two-ifs', H + '    if ((_pad_i_stat[1] & 1) == 0)\n        return 0;\n    if (_pad_i_stat[0] & 1)\n        return 1;\n    return 0;\n}\n'),
        ('nested', H + '    if (_pad_i_stat[1] & 1) {\n        if (_pad_i_stat[0] & 1)\n            return 1;\n    }\n    return 0;\n}\n'),
        ('local-ptr-two-ifs', H + '    unsigned long *p = _pad_i_stat;\n\n    if ((p[1] & 1) == 0)\n        return 0;\n    if (p[0] & 1)\n        return 1;\n    return 0;\n}\n'),
        ('and-return', H + '    return (_pad_i_stat[1] & 1) && (_pad_i_stat[0] & 1);\n}\n'),
        ('r-var-nested', H + '    int r = 0;\n\n    if (_pad_i_stat[1] & 1)\n        if (_pad_i_stat[0] & 1)\n            r = 1;\n    return r;\n}\n'),
        ('r-var-else', H + '    int r;\n\n    if ((_pad_i_stat[1] & 1) == 0)\n        r = 0;\n    else if (_pad_i_stat[0] & 1)\n        r = 1;\n    else\n        r = 0;\n    return r;\n}\n'),
        ('goto-out', H + '    int r = 0;\n\n    if ((_pad_i_stat[1] & 1) == 0)\n        goto out;\n    if ((_pad_i_stat[0] & 1) == 0)\n        goto out;\n    r = 1;\nout:\n    return r;\n}\n'),
        ('not-not', H + '    if (!(_pad_i_stat[1] & 1))\n        return 0;\n    if (!(_pad_i_stat[0] & 1))\n        return 0;\n    return 1;\n}\n'),
    ]
elif fn == '_pad_intr_ack':
    START = 'static int _pad_intr_ack(void)\n{'
    END = '/* PAD.obj +700 (LINK-STRIPPED, static)'
    H = 'static int _pad_intr_ack(void)\n{\n'
    B = '    *(unsigned short *)(_pad_joy_data + 10) = 0;\n'
    T = '    return 0;\n}\n\n'
    VARIANTS = [
        ('volatile-array2', H + '    volatile int i[2];\n\n' + B + '    i[0] = 10;\n    while (--i[0] != -1)\n        ;\n' + T),
        ('volatile-long-long-ish', H + '    volatile int i;\n    volatile int j;\n\n' + B + '    i = 10;\n    while (--i != -1)\n        ;\n' + T),
        ('for-loop', H + '    volatile int i;\n\n' + B + '    for (i = 10; --i != -1; )\n        ;\n' + T),
        ('volatile-array3', H + '    volatile int i[3];\n\n' + B + '    i[0] = 10;\n    while (--i[0] != -1)\n        ;\n' + T),
    ]
else:
    START = 'static int _pad_install_intr(void)\n{'
    END = '/* PAD.obj +540 (LINK-STRIPPED, static) */'
    H = 'static int _pad_install_intr(void)\n{\n'
    T = '    SysDeqIntRP(1, _pad_node);\n    SysEnqIntRP(1, _pad_node);\n    ExitCriticalSection();\n    return 1;\n}\n\n'
    VARIANTS = [
        ('ptr-local', H + '    long *p;\n\n    EnterCriticalSection();\n    p = &_pad_node[1];\n    p[0] = (long)_pad_intr_ack;\n    p[1] = (long)_pad_intr_verify;\n    _pad_node[0] = 0;\n    _pad_node[3] = 0;\n' + T),
        ('ptr-local-all', H + '    long *p;\n\n    EnterCriticalSection();\n    p = &_pad_node[1];\n    p[0] = (long)_pad_intr_ack;\n    p[1] = (long)_pad_intr_verify;\n    p[-1] = 0;\n    p[2] = 0;\n' + T),
        ('order-next-last', H + '    EnterCriticalSection();\n    _pad_node[1] = (long)_pad_intr_ack;\n    _pad_node[2] = (long)_pad_intr_verify;\n    _pad_node[3] = 0;\n    _pad_node[0] = 0;\n' + T),
    ]
if END == '\x00END':
    # last function in the file: END = end of file marker emulation
    a = src.index(START)
    END = src[a:][src[a:].index('}\n', src[a:].index('return 0;')) + 2:][:40] or '\n'
    if not END.strip():
        src2 = src + '/* end of PAD.c */\n'
        open('C:/Temp/nfs4-decomp/' + FILE, 'w', encoding='utf-8', newline='').write(src2)
        END = '/* end of PAD.c */'

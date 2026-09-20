FILE = 'recon/syslib/psx/libpad/PADENTRY.c'
START = 'extern int PadChkMtap(int port)\n{'
END = '/* PADENTRY.obj +824 (LINK-STRIPPED) : PadInfoComb'
src = open('C:/Temp/nfs4-decomp/' + FILE, encoding='utf-8').read()
a = src.index(START); b = src.index(END, a)
seg = src[a:b]
KEEP = seg[seg.index('}\n') + 2:]
H = 'extern int PadChkMtap(int port)\n{\n'
VARIANTS = [
    ('if-else-single-return', H + '    int r;\n\n    if (_padModeMtap != 0)\n        r = _padInfoDir[port >> 4].mode1 == 8;\n    else\n        r = 0;\n    return r;\n}\n' + KEEP),
    ('ternary', H + '    return _padModeMtap ? _padInfoDir[port >> 4].mode1 == 8 : 0;\n}\n' + KEEP),
    ('positive-if', H + '    if (_padModeMtap != 0)\n        return _padInfoDir[port >> 4].mode1 == 8;\n    return 0;\n}\n' + KEEP),
    ('and-form', H + '    return _padModeMtap != 0 && _padInfoDir[port >> 4].mode1 == 8;\n}\n' + KEEP),
    ('local-index', H + '    int n = port >> 4;\n\n    if (_padModeMtap == 0)\n        return 0;\n    return _padInfoDir[n].mode1 == 8;\n}\n' + KEEP),
]

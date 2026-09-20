FILE = 'recon/syslib/psx/libpad/PADMAIN.c'
START = 'extern int PadEnableCom(int mode)\n{'
END = '/* PADMAIN.obj +792 (LINK-STRIPPED) : _padChkVsync'
H = 'extern int PadEnableCom(int mode)\n{\n'


def body(decl, a0, a1, b0, b1, pre=''):
    return (H + decl + '\n' + pre + '    if (old != mode) {\n        _padIntExec = 0;\n'
            '        if (mode & 1) {\n            _padChanStart = 0;\n            if (%s >= 150)\n                _padFuncClrInfo(_padInfoDir);\n            %s = 0;\n'
            '        } else {\n            _padChanStart = 1;\n        }\n'
            '        if (mode & 2) {\n            _padChanStop = 1;\n            if (%s >= 150)\n                _padFuncClrInfo(_padInfoDir + 0xf0);\n            %s = 0;\n'
            '        } else {\n            _padChanStop = 0;\n        }\n        _padIntExec = 1;\n    }\n    return old;\n}\n\n') % (a0, a1, b0, b1)


VARIANTS = [
    ('old-assigned-separately', body('    int old;\n', '_padFramesSinceStart', '_padFramesSinceStart', '_padFramesSinceStop', '_padFramesSinceStop',
                                     '    old = (_padChanStop << 1) | (_padChanStart == 0);\n')),
    ('old-uchar-style-or-swapped', body('    int old = (_padChanStart == 0) | (_padChanStop << 1);\n', '_padFramesSinceStart', '_padFramesSinceStart',
                                        '_padFramesSinceStop', '_padFramesSinceStop')),
    ('pointer-locals-inside', body('    int old = (_padChanStop << 1) | (_padChanStart == 0);\n', '*f', '*f', '*g', '*g').replace(
        '        if (mode & 1) {\n', '        if (mode & 1) {\n            int *f = &_padFrames[0];\n').replace(
        '        if (mode & 2) {\n', '        if (mode & 2) {\n            int *g = &_padFrames[1];\n')),
    ('ternary-old', body('    int old = (_padChanStop << 1) | (_padChanStart ? 0 : 1);\n', '_padFramesSinceStart', '_padFramesSinceStart',
                         '_padFramesSinceStop', '_padFramesSinceStop')),
    ('mode-copy', body('    int old = (_padChanStop << 1) | (_padChanStart == 0);\n    int m = mode;\n', '_padFramesSinceStart', '_padFramesSinceStart',
                       '_padFramesSinceStop', '_padFramesSinceStop').replace('old != mode', 'old != m').replace('mode & 1', 'm & 1').replace('mode & 2', 'm & 2')),
]

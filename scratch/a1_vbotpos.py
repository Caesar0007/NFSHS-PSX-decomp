#!/usr/bin/env python3
"""Probe: move the `vbot = vh + v;` statement through the loop body."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from a1_probe import probe, read

STMT = '    vbot = vh + v;\r\n'

ANCHORS = {
    'top-of-body':      '    texX = (uint)(ushort)shp->shapex',
    'before-prim':      '    prim = Render_gPacketPtr;\r\n',
    'after-bump':       '    pal = (uint *)Render_gPalettePtr;\r\n',
    'after-pal':        '    /* EA-1998 addPrim(): P_TAG bitfield setaddr pair (house idiom). */',
    'after-col2':       '    *(int *)(prim + 0x1c) = color[2];\r\n',
    'before-c3':        '    c3 = color[3];\r\n',
    'before-prim7':     '    prim[7] = (flags & 1) * 2 + 0x3c;\r\n',
    'baseline-preclut': None,   # current position
    'after-clut':       "    *(short *)(prim + 0x1a) =\r\n",
    'after-addw':       '    addw = 0;\r\n',
    'at-use':           '    prim[0x25] = vbot;\r\n',
}


def mk(anchor, after):
    def f(t):
        t = t.replace(STMT, '', 1)
        assert 'vbot = vh + v' not in t
        i = t.index(anchor)
        if after:
            i += len(anchor)
        return t[:i] + STMT + t[i:]
    return f


if __name__ == '__main__':
    for name, anc in ANCHORS.items():
        if anc is None:
            continue
        after = name in ('before-prim', 'after-bump', 'after-col2', 'before-c3',
                         'after-addw')
        try:
            r = probe(mk(anc, after))
        except Exception as e:
            r = ['ERR %s' % e]
        print('%-16s %s' % (name, ' | '.join(r)))

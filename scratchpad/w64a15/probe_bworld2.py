"""w64a15 matrix #2 for bworld.cpp SetupChunkBuildList -- expression/identity shapes.
Usage: python probe_bworld2.py [variant ...]
"""
import os, sys, subprocess

REPO = r'C:\Temp\nfs4-decomp'
TU = os.path.join(REPO, r'recon\game\common\bworld.cpp')
BAK = os.path.join(REPO, r'scratchpad\w64a15\bworld.cpp.base')
REL = 'recon/game/common/bworld.cpp'
FN = 'SetupChunkBuildList__FP13DRender_tView'

NL = b'\r\n'


def J(*lines):
    return b''.join(l + NL for l in lines)


PAIR = J(b'    viewList =',
         b'        ((short (*)[32])Track_gInViewList)[gCurrContext->currentChunk];',
         b'    totalVisChunks =',
         b'        (int)*(u_char *)((char *)Track_gInViewCount +',
         b'                         gCurrContext->currentChunk);')

DECL_OLD = J(b'    int viewInd;', b'    short *viewList;')
DECL_CC = J(b'    int viewInd;', b'    short *viewList;', b'    int cc;')

# named currentChunk local
CC = J(b'    cc = gCurrContext->currentChunk;',
       b'    viewList = ((short (*)[32])Track_gInViewList)[cc];',
       b'    totalVisChunks = (int)*(u_char *)((char *)Track_gInViewCount + cc);')
CC_SWAP = J(b'    cc = gCurrContext->currentChunk;',
            b'    totalVisChunks = (int)*(u_char *)((char *)Track_gInViewCount + cc);',
            b'    viewList = ((short (*)[32])Track_gInViewList)[cc];')
# count read as an array subscript on an unsized u_char view
IDXFORM = J(b'    viewList =',
            b'        ((short (*)[32])Track_gInViewList)[gCurrContext->currentChunk];',
            b'    totalVisChunks =',
            b'        (int)((u_char *)Track_gInViewCount)[gCurrContext->currentChunk];')
# viewList via an explicit shifted byte offset (index-term-first)
SHIFTFORM = J(b'    viewList = (short *)((gCurrContext->currentChunk << 6)',
              b'                         + (int)Track_gInViewList);',
              b'    totalVisChunks =',
              b'        (int)*(u_char *)((char *)Track_gInViewCount +',
              b'                         gCurrContext->currentChunk);')
# viewList result immediately re-read (extra ref, raises its sched priority)
EXTRAREF = J(b'    viewList =',
             b'        ((short (*)[32])Track_gInViewList)[gCurrContext->currentChunk];',
             b'    totalVisChunks =',
             b'        (int)*(u_char *)((char *)Track_gInViewCount +',
             b'                         gCurrContext->currentChunk);',
             b'    __asm__("" : : "r"(viewList), "r"(totalVisChunks));')

V = {
    'control': [],
    'cc': [(DECL_OLD, DECL_CC), (PAIR, CC)],
    'cc_swap': [(DECL_OLD, DECL_CC), (PAIR, CC_SWAP)],
    'idxform': [(PAIR, IDXFORM)],
    'shiftform': [(PAIR, SHIFTFORM)],
    'extraref': [(PAIR, EXTRAREF)],
}


def write_atomic(path, data):
    tmp = path + '.tmpw'
    with open(tmp, 'wb') as f:
        f.write(data)
    assert os.path.getsize(tmp) == len(data)
    os.replace(tmp, path)


def run(cmd):
    return subprocess.run(cmd, cwd=REPO, capture_output=True, text=True, timeout=1800).stdout


def main():
    names = sys.argv[1:] or list(V)
    base = open(BAK, 'rb').read()
    try:
        for name in names:
            d = base
            ok = True
            for old, new in V[name]:
                if d.count(old) != 1:
                    print('%-12s ANCHOR-FAIL %d' % (name, d.count(old)))
                    ok = False
                    break
                d = d.replace(old, new)
            if not ok:
                continue
            write_atomic(TU, d)
            g = run([sys.executable, 'tools/verify_asm.py', REL, FN])
            line = [l.strip() for l in g.splitlines() if 'PASS' in l or 'FAIL' in l]
            print('%-12s %s' % (name, line[0] if line else g.strip()[:200]))
    finally:
        write_atomic(TU, base)


if __name__ == '__main__':
    main()

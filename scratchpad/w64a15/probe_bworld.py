"""w64a15 matrix probe for bworld.cpp SetupChunkBuildList.
Residual: sched2 sinks `addu s3,v1,a0` (viewList address) into the lbu's
load-delay slot, so we are 1 insn short and the %hi scratch flips v1->v0.
Usage: python probe_bworld.py [variant ...]      (no args = all)
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


VIEW = J(b'    viewList =',
         b'        ((short (*)[32])Track_gInViewList)[gCurrContext->currentChunk];')
COUNT = J(b'    totalVisChunks =',
          b'        (int)*(u_char *)((char *)Track_gInViewCount +',
          b'                         gCurrContext->currentChunk);')

COUNT_VOL = J(b'    totalVisChunks =',
              b'        (int)*(volatile u_char *)((char *)Track_gInViewCount +',
              b'                         gCurrContext->currentChunk);')

FENCE_VOID = J(b'    __asm__("" : : "i"(0));')
FENCE_RO_VIEW = J(b'    __asm__("" : : "r"(viewList));')
FENCE_ID_VIEW = J(b'    __asm__("" : "=r"(viewList) : "0"(viewList));')

# split the count address into its own pointer local + opacity fence on it
COUNT_PTR = J(b'    { u_char *cntp = (u_char *)Track_gInViewCount + gCurrContext->currentChunk;',
              b'      totalVisChunks = (int)*cntp; }')
COUNT_PTR_FENCE = J(b'    { u_char *cntp = (u_char *)Track_gInViewCount + gCurrContext->currentChunk;',
                    b'      __asm__("" : "=r"(cntp) : "0"(cntp));',
                    b'      totalVisChunks = (int)*cntp; }')

V = {
    'control': [],
    # w63a15 reference point: volatile byte read (expect 203/203 but +andi)
    'vol': [(COUNT, COUNT_VOL)],
    # identity/opacity fence on viewList, placed between the two statements
    'idview': [(VIEW, VIEW + FENCE_ID_VIEW)],
    # read-only fence on viewList between the two statements
    'roview': [(VIEW, VIEW + FENCE_RO_VIEW)],
    # void-tail fence between the two statements (re-measure the w61 falsification)
    'voidmid': [(VIEW, VIEW + FENCE_VOID)],
    # count address as its own pointer local
    'cntptr': [(COUNT, COUNT_PTR)],
    # ... plus an opacity fence on that pointer (blocks the sink without volatile)
    'cntptrfence': [(COUNT, COUNT_PTR_FENCE)],
    # identity fence on viewList AFTER the count statement
    'idview_after': [(COUNT, COUNT + FENCE_ID_VIEW)],
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
                    print('%-14s ANCHOR-FAIL %d' % (name, d.count(old)))
                    ok = False
                    break
                d = d.replace(old, new)
            if not ok:
                continue
            write_atomic(TU, d)
            g = run([sys.executable, 'tools/verify_asm.py', REL, FN])
            line = [l.strip() for l in g.splitlines() if 'PASS' in l or 'FAIL' in l]
            print('%-14s %s' % (name, line[0] if line else g.strip()[:160]))
    finally:
        write_atomic(TU, base)


if __name__ == '__main__':
    main()

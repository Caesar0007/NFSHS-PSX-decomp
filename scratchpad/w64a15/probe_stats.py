"""w64a15 probe for stats.cpp Stats_TrackEndGame -- gate + re-dumped allocno table.
Usage: python probe_stats.py <variant> [--keep]
"""
import os, sys, subprocess

REPO = r'C:\Temp\nfs4-decomp'
TU = os.path.join(REPO, r'recon\game\common\stats.cpp')
BAK = os.path.join(REPO, r'scratchpad\w64a15\stats.cpp.base')
REL = 'recon/game/common/stats.cpp'
FN = 'Stats_TrackEndGame__Fv'

NL = b'\r\n'


def J(*lines):
    return b''.join(l + NL for l in lines)


PP = J(b'        PlayerPosition = Stats_GetPosition(Cars_gHumanRaceCarList[i]);')
PP_FENCE = PP + J(b'        __asm__("" : : "r"(trackSlices));')

TERN = J(b'              DesiredSlice = trackSlices < Cars_gRaceCarList[j]->stats.sliceTotal ?',
         b'                             trackSlices : Cars_gRaceCarList[j]->stats.sliceTotal;')
TERN_TMP = J(b'              { int sliceTot = Cars_gRaceCarList[j]->stats.sliceTotal;',
             b'                __asm__("" : "=r"(sliceTot) : "0"(sliceTot));',
             b'                if (trackSlices < sliceTot) sliceTot = trackSlices;',
             b'                DesiredSlice = sliceTot; }')

V = {
    'control': [],
    'ppfence': [(PP, PP_FENCE)],
    'tmpmin': [(TERN, TERN_TMP)],
    'both': [(PP, PP_FENCE), (TERN, TERN_TMP)],
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
    name = sys.argv[1]
    keep = '--keep' in sys.argv
    base = open(BAK, 'rb').read()
    d = base
    for old, new in V[name]:
        assert d.count(old) == 1, (name, 'anchor', d.count(old), old[:50])
        d = d.replace(old, new)
    write_atomic(TU, d)
    try:
        g = run([sys.executable, 'tools/verify_asm.py', REL, FN])
        print('GATE', [l.strip() for l in g.splitlines() if 'PASS' in l or 'FAIL' in l][:1])
        run([sys.executable, 'tools/rtl_dump.py', REL])
        t = run([sys.executable, 'tools/multidial.py', 'scratch/rtl/stats.i.greg',
                 'scratch/rtl/stats.i.lreg', 'void Stats_TrackEndGame()',
                 '--want', 'p104=s4,p101=s5,p130=s6,p103=s7'])
        for l in t.splitlines():
            if ' s3 ' in l or ' s4 ' in l or ' s5 ' in l or ' s6 ' in l or ' s7 ' in l or 'MISMATCH' in l:
                print('   ', l.strip())
    finally:
        if not keep:
            write_atomic(TU, base)


if __name__ == '__main__':
    main()

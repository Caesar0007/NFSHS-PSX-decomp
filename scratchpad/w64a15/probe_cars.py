"""w64a15 probe harness for game/common/cars.cpp (production branch-word class).
Usage: python probe_cars.py <variant> [--keep]
"""
import os, sys, subprocess

REPO = r'C:\Temp\nfs4-decomp'
TU = os.path.join(REPO, r'recon\game\common\cars.cpp')
BAK = os.path.join(REPO, r'scratchpad\w64a15\cars.cpp.base')
REL = 'recon/game/common/cars.cpp'

NL = b'\r\n'


def J(*lines):
    return b''.join(l + NL for l in lines)


BLOWOUT = J(b'  if (carObj->blowout != 0) {', b'    return;', b'  }')
BLOWOUT_DUP = J(b'  if (carObj->blowout != 0) {',
                b'    (carObj->collision).smoking = 0;',
                b'    return;', b'  }')

# DoExtra: move the blowout re-test INSIDE the y!=0 arm as an inverted goto.
DX_OLD = J(b'      Cars_ResetCollidedCars(carObj,1,0);',
           b'    }',
           b'  }',
           b'  if (carObj->blowout == 0) {',
           b'    if (carObj->pullOver == 0) {')
DX_NEW = J(b'      Cars_ResetCollidedCars(carObj,1,0);',
           b'    }',
           b'    if (carObj->blowout != 0) goto afterPullOver;',
           b'  }',
           b'  {',
           b'    if (carObj->pullOver == 0) {')
DX_TAIL_OLD = J(b'      }', b'    }', b'  }',
                b'  if (carObj->stats.fatalCrashes > 0) {')
DX_TAIL_NEW = J(b'      }', b'    }', b'  }',
                b'afterPullOver:',
                b'  if (carObj->stats.fatalCrashes > 0) {')

# same, without the redundant bare block
DX2_NEW = J(b'      Cars_ResetCollidedCars(carObj,1,0);',
            b'    }',
            b'    if (carObj->blowout != 0) goto afterPullOver;',
            b'  }',
            b'  if (carObj->pullOver == 0) {')
DX2_TAIL_NEW = J(b'      }', b'    }',
                 b'afterPullOver:',
                 b'  if (carObj->stats.fatalCrashes > 0) {')

VARIANTS = {
    'control': [],
    'dupstore': [(BLOWOUT, BLOWOUT_DUP)],
    'dx_goto': [(DX_OLD, DX_NEW), (DX_TAIL_OLD, DX_TAIL_NEW)],
    'dx_goto2': [(DX_OLD, DX2_NEW), (DX_TAIL_OLD, DX2_TAIL_NEW)],
    'both': [(BLOWOUT, BLOWOUT_DUP), (DX_OLD, DX_NEW), (DX_TAIL_OLD, DX_TAIL_NEW)],
    'both2': [(BLOWOUT, BLOWOUT_DUP), (DX_OLD, DX2_NEW), (DX_TAIL_OLD, DX2_TAIL_NEW)],
}

FNS = ['Cars_ResetCollidedCars__FP8Car_tObjii',
       'Cars_DoExtraCarCollisionProcessing__FP8Car_tObj']


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
    for old, new in VARIANTS[name]:
        assert d.count(old) == 1, (name, 'anchor count', d.count(old), old[:60])
        d = d.replace(old, new)
    write_atomic(TU, d)
    try:
        fns = FNS[1:] if name.startswith('dx_') else FNS
        for fn in fns:
            g = run([sys.executable, 'tools/verify_asm.py', REL, fn])
            print('GATE', [l.strip() for l in g.splitlines() if 'PASS' in l or 'FAIL' in l][:1])
            p = run([sys.executable, 'tools/psyqproof.py', REL, fn])
            print('PROD', p.strip()[:400])
    finally:
        if not keep:
            write_atomic(TU, base)


if __name__ == '__main__':
    main()

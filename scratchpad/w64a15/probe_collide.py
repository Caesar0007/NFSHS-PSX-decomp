"""w64a15 matrix for collide.cpp Collide_DoActualObjectCollisionCheck.
Residual (14 @763/765): retail DEFERS dotz's `mflo $t3; addu $v1,$a0,$t3` past the
abs(dotx)/abs(doty) blocks AND past `slt $v0,$a1,$a3`, paying a nop in abs(dotz)'s
delay slot.  Two symmetric sites; every edit applies to both.
Usage: python probe_collide.py [variant ...]
"""
import os, sys, subprocess

REPO = r'C:\Temp\nfs4-decomp'
TU = os.path.join(REPO, r'recon\game\common\collide.cpp')
BAK = os.path.join(REPO, r'scratchpad\w64a15\collide.cpp.base')
REL = 'recon/game/common/collide.cpp'
FN = 'Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2'
FN2 = 'Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2'

NL = b'\r\n'


def J(*lines):
    return b''.join(l + NL for l in lines)


DOTZ = J(b'        dotz = normalz.x / 256 * (vel.x / 256) + normalz.y / 256 * (vel.y / 256) +',
         b'               normalz.z / 256 * (vel.z / 256);',
         b'        __asm__("");')
ABS3 = J(b'        if (dotx < 0) {', b'          dotx = -dotx;', b'        }',
         b'        if (doty < 0) {', b'          doty = -doty;', b'        }',
         b'        if (dotz < 0) {', b'          dotz = -dotz;', b'        }')
ABSXY = J(b'        if (dotx < 0) {', b'          dotx = -dotx;', b'        }',
          b'        if (doty < 0) {', b'          doty = -doty;', b'        }')
ABSZ = J(b'        if (dotz < 0) {', b'          dotz = -dotz;', b'        }')
CMP = J(b'        cmpyx = doty < dotx;')

# dotz split forms
DOTZ_ZONLY = J(b'        dotz = normalz.z / 256 * (vel.z / 256);', b'        __asm__("");')
DOTZ_XYTAIL = J(b'        dotz = dotz + normalz.x / 256 * (vel.x / 256) +',
                b'               normalz.y / 256 * (vel.y / 256);')
DOTZ_XYONLY = J(b'        dotz = normalz.x / 256 * (vel.x / 256) + normalz.y / 256 * (vel.y / 256);',
                b'        __asm__("");')
DOTZ_ZTAIL = J(b'        dotz = dotz + normalz.z / 256 * (vel.z / 256);')

V = {
    'control': [],
    # A: abs(dotx)/abs(doty) hoisted above the dotz assignment
    'absfirst': [(DOTZ, ABSXY + DOTZ), (ABS3, ABSZ)],
    # B: dotz's z-product (the mult retail issues first) stays ahead of the abs blocks,
    #    the x/y tail (mflo consumer) lands after them
    'zfirst_split': [(DOTZ, DOTZ_ZONLY + ABSXY + DOTZ_XYTAIL), (ABS3, ABSZ)],
    # C: x/y partial first, the z product (retail's mult) after the abs blocks
    'ztail_split': [(DOTZ, DOTZ_XYONLY + ABSXY + DOTZ_ZTAIL), (ABS3, ABSZ)],
}

DOTZ_ZPROD = J(b'        { int zprod = normalz.z / 256 * (vel.z / 256);',
               b'          int zpart = normalz.x / 256 * (vel.x / 256) +',
               b'                      normalz.y / 256 * (vel.y / 256);',
               b'        __asm__("");')
DOTZ_ZPROD_TAIL = J(b'          dotz = zpart + zprod; }')
V['zprod'] = [(DOTZ, DOTZ_ZPROD + ABSXY + DOTZ_ZPROD_TAIL), (ABS3, ABSZ)]
V['zprod_nofence'] = [(DOTZ, DOTZ_ZPROD.replace(J(b'        __asm__("");'), b'') + ABSXY + DOTZ_ZPROD_TAIL), (ABS3, ABSZ)]


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
                n = d.count(old)
                if n != 2:
                    print('%-13s ANCHOR-FAIL %d' % (name, n))
                    ok = False
                    break
                d = d.replace(old, new)
            if not ok:
                continue
            write_atomic(TU, d)
            g = run([sys.executable, 'tools/verify_asm.py', REL, FN + ',' + FN2])
            for l in g.splitlines():
                if 'PASS' in l or 'FAIL' in l:
                    print('%-13s %s' % (name, l.strip()[:110]))
    finally:
        write_atomic(TU, base)


if __name__ == '__main__':
    main()

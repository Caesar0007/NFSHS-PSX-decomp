import re, subprocess, sys, shutil, os
P = r'C:\Temp\nfs4-decomp\recon\game\common\newton.cpp'
BAK = r'C:\Temp\nfs4-decomp\scratchpad\w64a11\newton.sweep.bak'
FN = 'Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj'
shutil.copyfile(P, BAK)
base = open(P,'rb').read()
OLD = b'  __asm__("" : : "r"(collision_type), "r"(collision_type), "r"(collision_type), "r"(collision_type));'
assert base.count(OLD)==1
try:
    for n in (3,5,6,7,8):
        ops = b', '.join([b'"r"(collision_type)']*n)
        new = b'  __asm__("" : : ' + ops + b');'
        open(P,'wb').write(base.replace(OLD,new))
        r = subprocess.run([sys.executable,'tools/verify_asm.py','recon/game/common/newton.cpp',FN],
                           capture_output=True, text=True, cwd=r'C:\Temp\nfs4-decomp')
        line = [l for l in r.stdout.splitlines() if 'PASS' in l or 'FAIL' in l]
        print('n=%d %s' % (n, line[0].strip() if line else r.stdout[-200:]))
finally:
    shutil.copyfile(BAK, P)
    print('restored')

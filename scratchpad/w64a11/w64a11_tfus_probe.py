import subprocess, sys, shutil
P = r'C:\Temp\nfs4-decomp\recon\game\common\newton.cpp'
BAK = r'C:\Temp\nfs4-decomp\scratchpad\w64a11\newton.tfusprobe.bak'
FN = 'Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj'
shutil.copyfile(P, BAK)
base = open(P,'rb').read()
ANCHOR = b'    if (collision_type != 0) {\r\n      int impulse;\r\n      int zone;\r\n'
assert base.count(ANCHOR)==1, base.count(ANCHOR)
DECL = b'  int collision_type;\r\n'
assert base.count(DECL)==1
variants = {
 'V1 inner plain local'  : (None, ANCHOR + b'      int hit = 0;\r\n\r\n      if (hit != 0) {\r\n        return;\r\n      }\r\n'),
 'V2 inner sep assign'   : (None, ANCHOR + b'      int hit;\r\n\r\n      hit = 0;\r\n      if (hit != 0) {\r\n        return;\r\n      }\r\n'),
 'V3 fn-scope flag'      : (DECL + b'  int hit;\r\n', ANCHOR + b'      hit = 0;\r\n      if (hit != 0) {\r\n        return;\r\n      }\r\n'),
 'V4 fn-scope pre-if'    : (DECL + b'  int hit;\r\n', None),
}
try:
    for name,(declrep, anchrep) in variants.items():
        d = base
        if declrep: d = d.replace(DECL, declrep, 1)
        if anchrep: d = d.replace(ANCHOR, anchrep, 1)
        if name == 'V4 fn-scope pre-if':
            d = d.replace(b'    if (collision_type != 0) {\r\n', b'    hit = 0;\r\n    if (collision_type != 0) {\r\n      if (hit != 0) {\r\n        return;\r\n      }\r\n', 1)
        open(P,'wb').write(d)
        r = subprocess.run([sys.executable,'tools/verify_asm.py','recon/game/common/newton.cpp',FN],
                           capture_output=True, text=True, cwd=r'C:\Temp\nfs4-decomp')
        line = [l for l in r.stdout.splitlines() if 'PASS' in l or 'FAIL' in l]
        print('%-22s %s' % (name, line[0].strip() if line else (r.stdout+r.stderr)[-300:]))
finally:
    shutil.copyfile(BAK, P); print('restored')

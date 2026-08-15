import subprocess, sys, os
ROOT = r'C:\Temp\nfs4-decomp'
rel = 'recon/frontend/common/screenmain.cpp'
path = os.path.join(ROOT, rel)
cur = open(path, 'rb').read()
old = subprocess.run(['git', 'show', 'HEAD~3:' + rel], capture_output=True, cwd=ROOT).stdout
assert len(old) > 1000
try:
    open(path, 'wb').write(old)
    r = subprocess.run([sys.executable, 'tools/verify_asm.py', rel,
                        'DrawBackground__11tScreenMain'], capture_output=True,
                       text=True, cwd=ROOT)
    print('GATE:', [l for l in r.stdout.splitlines() if 'DrawBackground' in l])
    r = subprocess.run([sys.executable, 'tools/psyqproof.py', rel,
                        'DrawBackground__11tScreenMain'], capture_output=True,
                       text=True, cwd=ROOT)
    print('PSYQ:', r.stdout.strip().splitlines()[-1] if r.stdout.strip() else r.stderr[-300:])
finally:
    open(path, 'wb').write(cur)
    print('restored', len(cur))

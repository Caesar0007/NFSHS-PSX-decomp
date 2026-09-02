import subprocess, sys, io
P='regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp'
CUR = b"      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n"
variants = {
 'v_yxw': b"      r.y = 0x61;\r\n      r.x = r.x - 5;\r\n      r.w = r.w + 10;\r\n",
 'v_xwy': b"      r.x = r.x - 5;\r\n      r.w = r.w + 10;\r\n      r.y = 0x61;\r\n",
 'v_wyx': b"      r.w = r.w + 10;\r\n      r.y = 0x61;\r\n      r.x = r.x - 5;\r\n",
 'v_wxy': b"      r.w = r.w + 10;\r\n      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n",
 'v_ywx': b"      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n      r.x = r.x - 5;\r\n",
}
base = open(P,'rb').read()
assert base.count(CUR)==1, base.count(CUR)
for name, v in variants.items():
    open(P,'wb').write(base.replace(CUR, v))
    r = subprocess.run(['python','regiondiff/tools/verify_region.py','JPN',P,
        'DrawCongratsMessage__23tScreenTournamentTrophy','--lane-as=recon/frontend/common/screencongrats.cpp'],
        capture_output=True, text=True)
    line = [l for l in r.stdout.splitlines() if 'DrawCongratsMessage' in l]
    print(name, line[0].strip() if line else r.stdout[-200:]+r.stderr[-200:])
open(P,'wb').write(base)
print('restored to r.x/r.y/r.w order')

import subprocess
P='regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp'
H = b"      r.h = (short)(FETextRender_WordWrapHeight(r.w,buffer) + 6);\r\n"
X = b"      r.x = r.x - 5;\r\n"; Y = b"      r.y = 0x61;\r\n"; W = b"      r.w = r.w + 10;\r\n"
CUR = H + X + Y + W
variants = {
 'G_xhyw': X + H + Y + W,
 'H_xyhw': X + Y + H + W,
 'J_temp': b"      {\r\n        short plateH = FETextRender_WordWrapHeight(r.w,buffer);\r\n        r.h = plateH + 6;\r\n      }\r\n" + X + Y + W,
 'K_hyxw_short': H + b"      r.y = (short)0x61;\r\n" + X + W,
 'L_hxyw_wfirstload': H + b"      r.w = r.w + 10;\r\n      r.y = 0x61;\r\n      r.x = r.x - 5;\r\n",
}
base = open(P,'rb').read(); assert base.count(CUR)==1
for name, v in variants.items():
    open(P,'wb').write(base.replace(CUR, v))
    r = subprocess.run(['python','regiondiff/tools/verify_region.py','JPN',P,
        'DrawCongratsMessage__23tScreenTournamentTrophy','--lane-as=recon/frontend/common/screencongrats.cpp'],
        capture_output=True, text=True)
    line = [l for l in r.stdout.splitlines() if 'DrawCongratsMessage' in l]
    print(name, line[0].strip() if line else (r.stdout[-300:]+r.stderr[-300:]))
open(P,'wb').write(base); print('restored')

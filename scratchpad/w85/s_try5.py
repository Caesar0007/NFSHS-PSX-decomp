import subprocess
P='regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp'
H = b"      r.h = (short)(FETextRender_WordWrapHeight(r.w,buffer) + 6);\r\n"
CUR = H + b"      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n"
XYW = b"      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n"
variants = {
 'N1_6first' : b"      r.h = (short)(6 + FETextRender_WordWrapHeight(r.w,buffer));\r\n" + XYW,
 'N2_castcall': b"      r.h = (short)FETextRender_WordWrapHeight(r.w,buffer) + 6;\r\n" + XYW,
 'N5_scope'  : H + b"      {\r\n" + XYW + b"      }\r\n",
 'N6_yw_x'   : H + b"      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n      r.x = r.x - 5;\r\n",
 'N7_intx'   : H + b"      {\r\n        int nx = (int)r.x - 5;\r\n        r.y = 0x61;\r\n        r.x = (short)nx;\r\n        r.w = r.w + 10;\r\n      }\r\n",
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

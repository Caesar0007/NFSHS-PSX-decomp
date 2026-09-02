import subprocess
P='regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp'
H = b"      r.h = (short)(FETextRender_WordWrapHeight(r.w,buffer) + 6);\r\n"
CUR = H + b"      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n"
variants = {
 'M1_int_py' : H + b"      {\r\n        int plateY = 0x61;\r\n        r.x = r.x - 5;\r\n        r.y = plateY;\r\n        r.w = r.w + 10;\r\n      }\r\n",
 'M3_shorttmp': H + b"      {\r\n        short nx = r.x - 5;\r\n        short nw = r.w + 10;\r\n        r.y = 0x61;\r\n        r.x = nx;\r\n        r.w = nw;\r\n      }\r\n",
 'M6_xfirst' : H + b"      {\r\n        short nx = r.x - 5;\r\n        r.x = nx;\r\n        r.y = 0x61;\r\n        r.w = r.w + 10;\r\n      }\r\n",
 'M7_ptr'    : H + b"      {\r\n        RECT *pr = &r;\r\n        pr->x = pr->x - 5;\r\n        pr->y = 0x61;\r\n        pr->w = pr->w + 10;\r\n      }\r\n",
 'M8_ychain' : H + b"      r.x = r.x - 5;\r\n      r.w = r.w + 10;\r\n      r.y = (short)(0x61 + (r.h - r.h));\r\n",
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

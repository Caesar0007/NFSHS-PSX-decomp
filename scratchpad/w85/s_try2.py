import subprocess
P='regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp'
CUR = (b"      r.h = (short)(FETextRender_WordWrapHeight(r.w,buffer) + 6);\r\n"
       b"      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n")
H = b"      r.h = (short)(FETextRender_WordWrapHeight(r.w,buffer) + 6);\r\n"
variants = {
 'A_no_cast_h': b"      r.h = FETextRender_WordWrapHeight(r.w,buffer) + 6;\r\n      r.x = r.x - 5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n",
 'B_cast_xw'  : H + b"      r.x = (short)(r.x - 5);\r\n      r.y = 0x61;\r\n      r.w = (short)(r.w + 10);\r\n",
 'C_compound' : H + b"      r.x -= 5;\r\n      r.y = 0x61;\r\n      r.w += 10;\r\n",
 'D_y_first'  : b"      r.y = 0x61;\r\n" + H + b"      r.x = r.x - 5;\r\n      r.w = r.w + 10;\r\n",
 'E_plusneg'  : H + b"      r.x = r.x + -5;\r\n      r.y = 0x61;\r\n      r.w = r.w + 10;\r\n",
 'F_int_x'    : H + b"      r.x = (short)((int)r.x - 5);\r\n      r.y = 0x61;\r\n      r.w = (short)((int)r.w + 10);\r\n",
}
base = open(P,'rb').read()
assert base.count(CUR)==1
for name, v in variants.items():
    open(P,'wb').write(base.replace(CUR, v))
    r = subprocess.run(['python','regiondiff/tools/verify_region.py','JPN',P,
        'DrawCongratsMessage__23tScreenTournamentTrophy','--lane-as=recon/frontend/common/screencongrats.cpp'],
        capture_output=True, text=True)
    line = [l for l in r.stdout.splitlines() if 'DrawCongratsMessage' in l]
    print(name, line[0].strip() if line else (r.stdout[-300:]+r.stderr[-300:]))
open(P,'wb').write(base)
print('restored')

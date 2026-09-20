"""fevirt_tscreen.py phase 2e: finish what fevirt_tscreen4.py's assert stopped, and make tScreenCongrats's pure slot pure
only on its OWNER surface (other surfaces hold derived copies that do not redeclare it -- layout-only there)."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


s = rd('feapp.cpp')
s, n = re.subn(r'->ProcessInput\(i,keyVal \+ i,command \+ i\);', '->ProcessInput((tPlayer)i,keyVal[i],command[i]);', s)
print('feapp ProcessInput sites:', n)
wr('feapp.cpp', s)

s = rd('screencarselect.cpp')
s, n1 = re.subn(r'\(\*vtbl\[1\]\[6\]\.pfn\)\s*\(vtbl\[1\]\[6\]\.delta \+ -0x14 \+ this->fPermShapes\.fFilename\)', 'this->TurnOffVideoWall()', s)
s, n2 = re.subn(r'\(\*vtbl\[1\]\[7\]\.pfn\)\s*\(vtbl\[1\]\[7\]\.delta \+ -0x14 \+ this->fPermShapes\.fFilename\)', 'this->SetDialog()', s)
print('slot16/17 sites:', n1, n2)
wr('screencarselect.cpp', s)

for h in sorted(glob.glob(R + '*_types.h')):
    t = open(h, encoding='utf-8').read()
    a = '    virtual void DrawCongratsMessage() = 0;' + NL
    if a in t:
        t = t.replace(a, '#ifdef NFS4_TSCREENCONGRATS_OWNER' + NL + a + '#else' + NL +
                      '    virtual void DrawCongratsMessage();   /* layout-only off the owner surface */' + NL + '#endif' + NL)
        open(h, 'w', encoding='utf-8', newline='').write(t)
        print('ok', h.replace('\\', '/').split('/')[-1])
s = rd('screencongrats.cpp')
if 'NFS4_TSCREENCONGRATS_OWNER' not in s:
    i = s.index('#include')
    s = s[:i] + '#define NFS4_TSCREENCONGRATS_OWNER   /* ScreenCongrats.obj emits tScreenCongrats\'s table: slot 11 is __pure_virtual */' + NL + s[i:]
    wr('screencongrats.cpp', s)

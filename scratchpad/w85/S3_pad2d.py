"""Two-axis sweep for GetPSXPadValue: (decl block) x (body shape), fence removed."""
import subprocess, sys, shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
REL = 'recon/frontend/common/front.cpp'
tgt = ROOT / REL
snap = ROOT / 'scratchpad' / 'w85' / 'best' / 'front.cpp'
base = snap.read_text(encoding='utf-8', newline='')
CR = chr(13) + chr(10)
LF = chr(10)


def fix(s):
    return s.replace(CR, LF).replace(LF, CR)


DECL_OLD = "  int newControl;\n  int type;\n"
BODY_OLD = r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  __asm__("");
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""

DECLS = [
    ('base', DECL_OLD),
    ('regtype', "  int newControl;\n  register int type;\n"),
    ('typefirst', "  int type;\n  int newControl;\n"),
    ('regboth', "  register int newControl;\n  register int type;\n"),
]

BODIES = [
    ('plain-goto', r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  type = gPadinfo.buf[player * 4].ID;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  type = 0;
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""),
    ('perarm-temps', r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    goto GetPSXPadValue_noPad;
  }
  {
    int t1 = gPadinfo.buf[player * 4].ID;
    type = t1;
  }
  goto GetPSXPadValue_gotType;
GetPSXPadValue_noPad:
  {
    int t0 = 0;
    type = t0;
  }
  goto GetPSXPadValue_gotType;
GetPSXPadValue_gotType:
"""),
    ('uchar-t', r"""  PAD_update();
  {
  u_char t;
  if (gPadinfo.buf[player * 4].nopad != '\0') { t = 0; }
  else { t = gPadinfo.buf[player * 4].ID; }
  type = t;
  }
"""),
    ('ifelse', r"""  PAD_update();
  if (gPadinfo.buf[player * 4].nopad != '\0') {
    type = 0;
  } else {
    type = gPadinfo.buf[player * 4].ID;
  }
"""),
]

for dn, dv in DECLS:
    for bn, bv in BODIES:
        t = base.replace(fix(DECL_OLD), fix(dv)).replace(fix(BODY_OLD), fix(bv))
        tgt.write_text(t, encoding='utf-8', newline='')
        r = subprocess.run([sys.executable, str(ROOT / 'tools' / 'tugate.py'), REL],
                           cwd=str(ROOT), capture_output=True, text=True)
        out = (r.stdout + r.stderr).strip().splitlines()
        summ = [l for l in out if l.strip().endswith('PASS') and '/' in l]
        fails = [l for l in out if l.strip() and l.strip()[0].isdigit()]
        print("%-14s %-14s %s %s" % (dn, bn,
              summ[-1].strip() if summ else 'COMPILE-FAIL',
              ' ; '.join(f.strip() for f in fails[:3])))

shutil.copyfile(snap, tgt)
print('[reverted]')

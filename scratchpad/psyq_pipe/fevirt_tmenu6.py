"""fevirt_tmenu.py phase 3b: femenudefs.obj.
  * the tBlank* destructors sit BETWEEN ordinary functions in retail (TIF32, Draw32iib, Draw32b, ~32, TIF33, Draw33iib, ~33)
    => they are user-written, out-of-line, EMPTY destructors defined at those points (an empty user dtor whose base dtor is
    out-of-line compiles to the bare `jal ~Base` retail has);
  * FEMenuDefs must see the REAL tPlayer enum: with `#define tPlayer int` the tBlank* tables referenced
    ProcessInput__...i... (overloads instead of overrides)."""
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


s = rd(FE + 'femenudefs.cpp')
for cls, base in (('tBlankMenuItemGoToMenuNFS4Button', 'tMenuItemGoToMenuNFS4Button'),
                  ('tBlankMenuItemNFS4LeftRightChoice', 'tMenuItemNFS4LeftRightChoice')):
    hdr = '/* ---- %s::dtor  [FEMENUDEFS.CPP:?] ---- */' % cls
    assert s.count(hdr) == 1, cls
    i = s.index(hdr)
    j = s.index('extern "C" void ___', i)
    j = s.index(NL, j) + 1
    s = (s[:i] + hdr + NL + NL +
         '/* A user-written EMPTY destructor, defined here in source order (retail has it between its siblings, not in the' + NL +
         ' * deferred tail): with an out-of-line base destructor it compiles to the bare `jal ~%s`. */' % base + NL +
         '%s::~%s() {}' % (cls, cls) + NL + s[j:])
wr(FE + 'femenudefs.cpp', s)

for h in ('screendisplay_types.h', 'screentrackinfo_types.h'):
    t = rd(FE + h)
    n = 0
    for cls in ('tBlankMenuItemGoToMenuNFS4Button', 'tBlankMenuItemNFS4LeftRightChoice'):
        m = re.search(r'^struct ' + cls + r'\b[^{]*\{\n#ifdef NFS4_FEMENUDEFS_SURFACE\n', t, re.M)
        if m:
            t = t[:m.end()] + '    ~%s();' % cls + NL + t[m.end():]
            n += 1
    if n:
        wr(FE + h, t)

d = rd(FE + 'femenudefs_types.h')
old = '#define tPlayer int' + NL + '#define kPlayerBoth -1' + NL + '#define kPlayerOne 0' + NL + '#define kPlayerTwo 1' + NL
assert d.count(old) == 1
d = d.replace(old, '/* (2026-09-19) the real tPlayer enum: FEMenuDefs.obj emits the tBlank* vtables, and with `#define tPlayer int` their' + NL +
              ' * ProcessInput slots named the `i`-mangled overloads instead of the overrides. */' + NL + '#include "fe_player_types.h"' + NL)
wr(FE + 'femenudefs_types.h', d)

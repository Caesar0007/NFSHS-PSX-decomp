"""fevirt_tmenu.py phase 3c (supersedes 3b's user destructors): the tBlank* classes are ALL-INLINE.
Retail's femenudefs.obj tail  TIF32, Draw32(iib), Draw32(b), ~32, TIF33, Draw33(iib), ~33  is the deferred-inline batch:
one group per class in REVERSE class order (class 33 is declared before class 32), members in DECLARATION order, the
compiler-synthesized destructor last.  (Same rule explains femenuextended.obj's tail.)  So: in-class inline bodies,
no declared destructor, no out-of-line definitions."""
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


t = rd(FE + 'screendisplay_types.h')
for cls in ('tBlankMenuItemGoToMenuNFS4Button', 'tBlankMenuItemNFS4LeftRightChoice'):
    t = t.replace('    ~%s();' % cls + NL, '')
    m = re.search(r'^struct ' + cls + r'\b[^{]*\{', t, re.M)
    e = t.index(NL + '};', m.end())
    body = t[m.end():e]
    body = body.replace('    bool TransitionIsFinished();', '    bool TransitionIsFinished() { return true; }')
    body = body.replace('    void Draw(int, int, bool);', '    void Draw(int, int, bool) {}')
    body = body.replace('    void Draw(bool);', '    void Draw(bool) {}')
    t = t[:m.end()] + body + t[e:]
wr(FE + 'screendisplay_types.h', t)

s = rd(FE + 'femenudefs.cpp')
a = s.index('/* ---- TransitionIsFinished  [FEMENUDEFS.CPP:?] ---- */' + NL + 'bool tBlankMenuItemGoToMenuNFS4Button::TransitionIsFinished()')
b = s.index('/* W60-A10: the three tBlankMenuItem::Draw nullsub exports that used to sit HERE were moved')
s = (s[:a] + '/* The tBlank* classes are ALL-INLINE (screendisplay_types.h): TransitionIsFinished / Draw bodies and the synthesized' + NL +
     ' * destructors are emitted by the compiler as the deferred-inline batch that closes this object --' + NL +
     ' *   TIF32, Draw32(iib), Draw32(b), ~32, TIF33, Draw33(iib), ~33  (reverse class order, declaration order inside). */' + NL + NL + s[b:])
wr(FE + 'femenudefs.cpp', s)

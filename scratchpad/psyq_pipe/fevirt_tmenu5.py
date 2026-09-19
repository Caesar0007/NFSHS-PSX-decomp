"""fevirt_tmenu.py phase 3a: femenuextended.obj's tail.  Retail ends with
    IsSubMenu__12tMenuOptions, UpdateTransition__10tMenuBlank, ~tMenuItemOptionsTwoItemChoice,
    ~tMenuItemOptionsLeftRightChoice, Draw__27tMenuItemGoToMenuNFS4Buttonb
The two destructors are compiler-synthesized (deferred batch, reverse class order); Draw(bool) coming AFTER them means it
is part of that batch too, i.e. an IN-CLASS inline `void Draw(bool) {}` of the class declared first."""
import re

R = 'C:/Temp/nfs4-decomp/'
NL = chr(10)
FE = 'recon/frontend/common/'
f = FE + 'femenuextended.cpp'
s = open(R + f, encoding='utf-8').read()
a = s.index('/* ---- tMenuItemGoToMenuNFS4Button::Draw  [FEMENUEXTENDED.CPP:?] SLD-FLAG:NO_SLD ---- */')
b = s.index('/* end of femenuextended.cpp */')
s = (s[:a] + '/* tMenuItemGoToMenuNFS4Button::Draw(bool) is an in-class inline (femenuextended_types.h): retail emits it in the' + NL +
     ' * deferred-inline batch, AFTER the two synthesized Options* destructors. */' + NL + NL + s[b:])
open(R + f, 'w', encoding='utf-8', newline='').write(s)
for h in ('femenuextended_types.h', 'screendisplay_types.h', 'screentrackinfo_types.h'):
    t = open(R + FE + h, encoding='utf-8').read()
    m = re.search(r'^struct tMenuItemGoToMenuNFS4Button\b[^{]*\{', t, re.M)
    if not m:
        continue
    e = t.index(NL + '};', m.end())
    body = t[m.end():e]
    body2, n = re.subn(r'^([ \t]*)void Draw\(bool\);', r'\1void Draw(bool) {}   /* in-class inline: see femenuextended.cpp tail */', body, flags=re.M)
    print(h, 'Draw(bool) decls changed:', n)
    open(R + FE + h, 'w', encoding='utf-8', newline='').write(t[:m.end()] + body2 + t[e:])

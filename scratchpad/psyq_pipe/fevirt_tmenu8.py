"""fevirt_tmenu.py phase 4: tMenu's place in FEMenu.obj's declaration order.
Retail FEMenu.obj tables: tMenu, GoToMenuButton, LeftRightSlider, LeftRightChoice, Interactive, tMenuItem -- reverse
declaration order => tMenu is declared AFTER tMenuItemGoToMenuButton in femenu.cpp's translation unit.  fe_core_types.h
defined it right after tMenuItem, so its definition moves to fe_core_tmenu.h: included in place by default, and by
femenu_types.h after its three item classes (NFS4_FE_CORE_TMENU_AFTER_ITEMS)."""
R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)
h = open(R + 'fe_core_types.h', encoding='utf-8').read()
a = h.index('struct tMenu {')
i = h.index('{', a) + 1
depth = 1
while depth:
    depth += h[i] == '{'
    depth -= h[i] == '}'
    i += 1
assert h[i] == ';'
i += 1
body = h[a:i]
h = (h[:a] + '/* tMenu is defined in fe_core_tmenu.h.  FEMenu\'s owner surface places it AFTER its three item classes (retail table' + NL +
     ' * order); every other surface gets it here. */' + NL + '#ifndef NFS4_FE_CORE_TMENU_AFTER_ITEMS' + NL +
     '#include "fe_core_tmenu.h"' + NL + '#endif' + h[i:])
open(R + 'fe_core_types.h', 'w', encoding='utf-8', newline='').write(h)
open(R + 'fe_core_tmenu.h', 'w', encoding='utf-8', newline='').write(
    '/* frontend/common/fe_core_tmenu.h -- the tMenu root class (real virtuals).  A separate piece of fe_core_types.h only so' + NL +
    ' * that FEMenu\'s translation unit can declare it after tMenuItemGoToMenuButton: g++ 2.8 emits vtables in reverse' + NL +
    ' * declaration order and FEMenu.obj has tMenu\'s table FIRST. */' + NL +
    '#ifndef NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H' + NL + '#define NFS4_FRONTEND_COMMON_FE_CORE_TMENU_H' + NL + NL + body + NL + NL + '#endif' + NL)
t = open(R + 'femenu_types.h', encoding='utf-8').read()
x = '#define NFS4_FE_CORE_FEMENU_METHODS' + NL + '#include "fe_core_types.h"' + NL
assert t.count(x) == 1
t = t.replace(x, '#define NFS4_FE_CORE_FEMENU_METHODS' + NL + '#define NFS4_FE_CORE_TMENU_AFTER_ITEMS   /* tMenu comes after the item classes below */' + NL +
              '#include "fe_core_types.h"' + NL)
y = 'struct tFEApplication;' + NL
assert t.count(y) == 1
t = t.replace(y, '#include "fe_core_tmenu.h"   /* retail order: ..., tMenuItemGoToMenuButton, tMenu */' + NL + NL + y)
open(R + 'femenu_types.h', 'w', encoding='utf-8', newline='').write(t)
print('ok')

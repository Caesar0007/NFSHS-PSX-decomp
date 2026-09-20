"""fevirt_tscreen.py phase 2f: give EVERY owner surface the three types the root virtuals' signatures need
(tPlayer, tInputKeyType, tMenuCommand) through one small header, fescreen_virtual_types.h, so the layout-only placeholder
signatures (tScreen AND the menu roots) can go: fe_input_enums.h is the single guarded definition of tInputKeyType,
tMenuCommand only needs a forward declaration, and surfaces that spell `#define tPlayer int` keep doing so."""
import glob
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)
open(R + 'fescreen_virtual_types.h', 'w', encoding='utf-8', newline='').write(
    '/* frontend/common/fescreen_virtual_types.h -- the types named by the front-end ROOT virtuals (tScreen, tMenuItem, tMenu):' + NL +
    ' * tPlayer, tInputKeyType and (by reference only) tMenuCommand.  Every owner surface needs them to DECLARE the virtuals, even' + NL +
    ' * if it never calls them.  A surface that spells `#define tPlayer int` keeps that spelling. */' + NL +
    '#ifndef NFS4_FRONTEND_COMMON_FESCREEN_VIRTUAL_TYPES_H' + NL + '#define NFS4_FRONTEND_COMMON_FESCREEN_VIRTUAL_TYPES_H' + NL + NL +
    '#if defined(tPlayer) && !defined(NFS4_FE_INPUT_NO_PLAYER)' + NL + '#define NFS4_FE_INPUT_NO_PLAYER' + NL +
    '#include "fe_input_enums.h"' + NL + '#undef NFS4_FE_INPUT_NO_PLAYER' + NL + '#else' + NL + '#include "fe_input_enums.h"' + NL + '#endif' + NL +
    'struct tMenuCommand;' + NL + NL + '#endif' + NL)
n = 0
for h in sorted(glob.glob(R + '*.h')):
    t = open(h, encoding='utf-8').read()
    if '#include "fescreen_virtuals.inc"' in t and 'fescreen_virtual_types.h' not in t:
        t = re.sub(r'^struct tScreen \{', '#include "fescreen_virtual_types.h"' + NL + 'struct tScreen {', t, count=1, flags=re.M)
        open(h, 'w', encoding='utf-8', newline='').write(t)
        n += 1
print('tScreen surfaces:', n)
f = R + 'fescreen_virtuals.inc'
t = open(f, encoding='utf-8').read()
t = re.sub(r'#ifndef NFS4_TSCREEN_LAYOUT_ONLY_PROCESSINPUT\n(    virtual void ProcessInput\([^\n]*\n)#else\n[^\n]*\n#endif\n', r'\1', t)
t = t.replace(' Surfaces without tInputKeyType / tMenuCommand define' + NL + ' * NFS4_TSCREEN_LAYOUT_ONLY_PROCESSINPUT and get a same-slot placeholder they can neither define nor call. */',
              ' The three types the signatures name come from' + NL + ' * fescreen_virtual_types.h, included before every copy. */')
open(f, 'w', encoding='utf-8', newline='').write(t)
SIG = re.compile(r'#if defined\(NFS4_FE_CORE_FEMENU_METHODS\) \|\| defined\(NFS4_FE_CORE_FEDIALOG_METHODS\)\n(    virtual void ProcessInput\(tPlayer, tInputKeyType &, tMenuCommand &\);\n)#else\n[^\n]*\n#endif\n')
for f in ('fe_core_types.h', 'fe_core_tmenu.h'):
    t = open(R + f, encoding='utf-8').read()
    t, k = SIG.subn(r'\1', t)
    if f == 'fe_core_types.h' and 'fescreen_virtual_types.h' not in t:
        t = t.replace('#include "felist_classes.h"', '#include "fescreen_virtual_types.h"' + NL + '#include "felist_classes.h"', 1)
    open(R + f, 'w', encoding='utf-8', newline='').write(t)
    print(f, 'placeholder signatures removed:', k)

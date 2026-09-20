"""fevirt_tscreen.py phase 3b: the last owner surfaces that erased tPlayer / tMenuCommand with macros.
With real virtuals an override must have the ROOT's parameter types or it silently becomes an overload (the vtable then
names the base method: undefined `ProcessInput__7tScreeni...`).  feapp, screencontroller, screenmain and screentournselect
now use the real enum (fe_player_types.h) and the real struct tag."""
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)


def edit(f, fn):
    s = open(R + f, encoding='utf-8').read()
    s2 = fn(s)
    assert s2 != s, f
    open(R + f, 'w', encoding='utf-8', newline='').write(s2)
    print('ok', f)


NOTE = '/* (2026-09-20) real tPlayer enum: overrides of the root virtuals need the root\'s parameter types */' + NL
edit('feapp_types.h', lambda s: re.sub(r'^#define kPlayer(?:One|Two|Both) -?\d+\n', '', s.replace(
    '#define tPlayer int' + NL + '#define NFS4_FE_INPUT_NO_PLAYER' + NL + '#include "fe_input_enums.h"' + NL + '#undef NFS4_FE_INPUT_NO_PLAYER' + NL,
    NOTE + '#include "fe_input_enums.h"' + NL), flags=re.M))
for f in ('screencontroller_types.h', 'screentournselect_types.h'):
    edit(f, lambda s: re.sub(r'#ifdef (NFS4_\w+)\n#include "fe_player_types.h"\n#else\n#define tPlayer int\n#endif\n',
                             NOTE + '#include "fe_player_types.h"' + NL, s, count=1))
edit('screenmain_types.h', lambda s: s.replace('#define tPlayer int' + NL + '#define tMenuCommand int' + NL,
                                               NOTE + '#include "fe_player_types.h"' + NL + 'struct tMenuCommand;' + NL))

"""fevirt_tscreen.py phase 4a: dialog class ORDER in FEDialog.obj's translation unit.
Retail tables (and the synthesized-destructor tail) are YesNoTri, YesNoMem, YesNo, Interactive, NoInputMessage, BackUpOnly,
MessageString, Help, Base = reverse declaration order, so fedialog.cpp must see
    Base, Help, MessageString, BackUpOnly, NoInputMessage, Interactive, YesNo, YesNoMem, YesNoTri.
Help / NoInputMessage (screenmemcard_types.h) and BackUpOnly (fedialog_types.h) become guarded include pieces; their old
places include the piece (no-op when already seen) and screendisplay_types.h pulls them in early on the FEDialog surface.
Also restores `~tScreenCarSelectTwoPlayer() {}` that a hoist dropped."""
import re

R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def cut(text, cls):
    m = re.search(r'^struct ' + cls + r'\b[^{;]*\{', text, re.M)
    i, depth = m.end(), 1
    while depth:
        depth += text[i] == '{'
        depth -= text[i] == '}'
        i += 1
    assert text[i] == ';'
    i += 1
    return text[:m.start()], text[m.start():i], text[i:]


def piece(name, cls, body, why):
    g = 'NFS4_FRONTEND_COMMON_' + name.upper().replace('.', '_')
    wr(name, '/* frontend/common/%s -- %s, as a guarded include piece: %s */' % (name, cls, why) + NL +
       '#ifndef ' + g + NL + '#define ' + g + NL + NL + body + NL + NL + '#endif' + NL)


WHY = 'FEDialog.obj needs it declared at a fixed place in the dialog class order (see screendisplay_types.h)'
s = rd('screenmemcard_types.h')
a, help_, b = cut(s, 'tDialogHelp')
s = a + '#include "fedialog_class_help.h"' + b
a, noin, b = cut(s, 'tDialogNoInputMessage')
s = a + '#include "fedialog_class_noinput.h"' + b
wr('screenmemcard_types.h', s)
s = rd('fedialog_types.h')
a, bak, b = cut(s, 'tDialogBackUpOnly')
wr('fedialog_types.h', a + '#include "fedialog_class_backuponly.h"' + b)
piece('fedialog_class_help.h', 'tDialogHelp', help_, WHY)
piece('fedialog_class_noinput.h', 'tDialogNoInputMessage', noin, WHY)
piece('fedialog_class_backuponly.h', 'tDialogBackUpOnly', bak, WHY)

s = rd('screendisplay_types.h')
m = re.search(r'^struct tDialogMessageString\b', s, re.M)
s = (s[:m.start()] + '#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS   /* FEDialog.obj: retail order is Base, Help, MessageString, ... */' + NL +
     '#include "fedialog_class_help.h"' + NL + '#endif' + NL + s[m.start():])
m = re.search(r'^struct tDialogInteractive\b', s, re.M)
s = (s[:m.start()] + '#ifdef NFS4_SCREENDISPLAY_FEDIALOG_METHODS   /* ..., MessageString, BackUpOnly, NoInputMessage, Interactive, ... */' + NL +
     '#include "fedialog_class_backuponly.h"' + NL + '#include "fedialog_class_noinput.h"' + NL + '#endif' + NL + s[m.start():])
wr('screendisplay_types.h', s)

s = rd('screencarselect_types.h')
x = '    tScreenCarSelectTwoPlayer();' + NL
assert s.count(x) == 1 and '~tScreenCarSelectTwoPlayer()' not in s
wr('screencarselect_types.h', s.replace(x, x + '    ~tScreenCarSelectTwoPlayer() {}' + NL))

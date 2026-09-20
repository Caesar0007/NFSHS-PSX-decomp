"""fevirt_tscreen.py phase 4b: RETIRE the feapp `#pragma interface/implementation` carrier.
tDialogMessageStringWithTimeout is an ordinary ALL-INLINE polymorphic class: an inline constructor (timeOutTicks = 0x480,
defined in feapp.cpp) and a compiler-synthesized destructor.  With real virtuals FEApp.obj emits its private table and the
destructor the table names by itself -- which is exactly what retail's FEApp.obj contains (table 0x80010098,
___31tDialogMessageStringWithTimeout in the object's tail).  The helper base and the pragmas were an imitation of that."""
R = 'C:/Temp/nfs4-decomp/recon/frontend/common/'
NL = chr(10)
f = R + 'fedialog_timeout_class.h'
s = open(f, encoding='utf-8').read()
a = s.index('#ifndef NFS4_FEDIALOG_TIMEOUT_CLASS_H')
open(f, 'w', encoding='utf-8', newline='').write(
    '/* frontend/common/fedialog_timeout_class.h -- tDialogMessageStringWithTimeout.' + NL +
    ' * An all-inline polymorphic class (2026-09-20, real virtuals): every object that constructs one emits a private copy of' + NL +
    ' * its table and the synthesized destructor the table names -- in retail that is FEApp.obj only (table 0x80010098).' + NL +
    ' * The former `#pragma interface` carrier and its helper base are gone. */' + NL +
    '#ifndef NFS4_FEDIALOG_TIMEOUT_CLASS_H' + NL + '#define NFS4_FEDIALOG_TIMEOUT_CLASS_H' + NL + NL +
    'struct tDialogMessageStringWithTimeout : public tDialogMessageString {' + NL +
    '#ifdef NFS4_SCREENMEMCARD_FEAPP_METHODS' + NL + '    tDialogMessageStringWithTimeout();   /* inline, feapp.cpp */' + NL + '#endif' + NL +
    '};' + NL + NL + '#endif' + NL)
f = R + 'feapp.cpp'
s = open(f, encoding='utf-8').read()
x = '#pragma implementation "fedialog_timeout_class.h"' + NL
assert s.count(x) == 1
s = s.replace(x, '')
y = ('/* the constructor stores live in the helper base (see fedialog_timeout_class.h) */' + NL +
     'inline tDialogMessageStringWithTimeoutInit::tDialogMessageStringWithTimeoutInit()' + NL)
assert s.count(y) == 1
s = s.replace(y, 'inline tDialogMessageStringWithTimeout::tDialogMessageStringWithTimeout()' + NL)
open(f, 'w', encoding='utf-8', newline='').write(s)
print('ok')

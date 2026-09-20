"""speech_nest3.py -- one shared, guarded `speech_class.h`: the SPCHNFSType_* flag words + the complete `struct Speech`
(nested classes, real static members fgSpeech / fgUndefined).  speech_types.h and copspeak_types.h (so nfs3 / cars too)
include it; nfs3.cpp constructs / destroys Speech with new / delete; speech.cpp defines the static members."""
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)


def rd(f):
    return open(R + f, encoding='utf-8').read()


def wr(f, s):
    open(R + f, 'w', encoding='utf-8', newline='').write(s)
    print('ok', f)


def block_end(text, start):
    i, depth = text.index('{', start) + 1, 1
    while depth:
        depth += text[i] == '{'
        depth -= text[i] == '}'
        i += 1
    assert text[i] == ';'
    return i + 1


h = rd('speech_types.h')
a = h.index('struct SPCHNFSType_POSITION')
b = h.index('struct SPCHNFSType_VOICE')
b = h.index(NL, b) + 1
flags = h[a:b]
c = h.index('struct Speech {')
d = block_end(h, c)
cls = h[c:d]
x = '    static Speaker *Mobile(Car_tObj *carObj);' + NL
assert cls.count(x) == 1
cls = cls.replace(x, x + '    static Speech *fgSpeech;' + NL + '    static Speaker *fgUndefined;' + NL)
h = h[:a] + '#include "speech_class.h"' + NL + h[b:c] + h[d:]
wr('speech_types.h', h)
wr('speech_class.h',
   '/* game/common/speech_class.h -- class Speech (SPEECH.CPP) with its nested classes, shared by every surface that' + NL +
   ' * constructs it or names its static members.  Needs only u_long and an (incomplete) Car_tObj. */' + NL +
   '#ifndef NFS4_GAME_COMMON_SPEECH_CLASS_H' + NL + '#define NFS4_GAME_COMMON_SPEECH_CLASS_H' + NL + NL +
   'struct Car_tObj;' + NL + NL + flags + NL + cls + NL + NL + '#endif' + NL)

t = rd('copspeak_types.h')
a = t.index('struct SPCHNFSType_POSITION')
b = t.index('struct SPCHNFSType_REVINTRO')
b = t.index(NL, b) + 1
t = t[:a] + t[b:]
for line in ('struct CarBank { int fFull, fMake, fModel; };', 'struct LocationBank { int fStartSlice, fEndSlice, fBankId; char *fName; };',
             'struct CallSignBank { int fAllUnits, fDispatch; int fMobile[15]; };'):
    assert t.count(line + NL) == 1
    t = t.replace(line + NL, '')
c = t.index('/* Speech, as this surface needs it')
d = block_end(t, t.index('struct Speech {', c))
t = t[:c] + '#include "speech_class.h"   /* NFS3.CPP constructs Speech and its undefined Speaker */' + t[d:]
wr('copspeak_types.h', t)

e = rd('nfs3_externs.h')
for pat in (r'^void \*__6Speech\(void \*\);\n', r'^void ___6Speech\(void \*, int\);\n',
            r'^extern Speaker \*Speech_fgUndefined asm\("_6Speech_fgUndefined"\);\n[^\n]*/\* Speech::fgUndefined \*/\n',
            r'^extern int _6Speech_fgSpeech;[^\n]*\n', r'^extern void Speech_Reset\(\) asm\("Reset__6Speech"\);\n'):
    e, n = re.subn(pat, '', e, flags=re.M)
    assert n == 1, pat
wr('nfs3_externs.h', e)

s = rd('nfs3.cpp')
for old, new in (('  if (Speech_fgUndefined == 0) {' + NL + '    Speech_fgUndefined = new Speaker;',
                  '  if (Speech::fgUndefined == 0) {' + NL + '    Speech::fgUndefined = new Speech::Speaker;'),
                 ('(_6Speech_fgSpeech == 0)) {' + NL + '    _6Speech_fgSpeech = (int)__6Speech(__builtin_new(0x3a4));',
                  '(Speech::fgSpeech == 0)) {' + NL + '    Speech::fgSpeech = new Speech;'),
                 ('  if (_6Speech_fgSpeech != 0) {' + NL + '    ___6Speech((void *)_6Speech_fgSpeech,3);' + NL + '    _6Speech_fgSpeech = 0;',
                  '  if (Speech::fgSpeech != 0) {' + NL + '    delete Speech::fgSpeech;' + NL + '    Speech::fgSpeech = 0;'),
                 ('  Speech_Reset();', '  Speech::Reset();')):
    assert s.count(old) == 1, old
    s = s.replace(old, new)
wr('nfs3.cpp', s)

s = rd('speech.cpp')
for old, new in (('Speech *Speech_fgSpeech __asm__("_6Speech_fgSpeech") = 0;', 'Speech *Speech::fgSpeech = 0;'),
                 ('Speech::Speaker *Speech_fgUndefined __asm__("_6Speech_fgUndefined") = 0;', 'Speech::Speaker *Speech::fgUndefined = 0;')):
    assert s.count(old) == 1, old
    s = s.replace(old, new)
s = re.sub(r'\bSpeech_fg(Speech|Undefined)\b', r'Speech::fg\1', s)
wr('speech.cpp', s)

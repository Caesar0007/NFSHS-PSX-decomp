"""speech_nest2.py -- the AI / cop surfaces: their private `struct Speaker` copy becomes `Speech::Speaker` (nested, virtuals
from the shared .inc, no asm labels) and the asm-labelled free functions Speech_Mobile / Speech_Dispatch become the real
static members Speech::Mobile / Speech::Dispatch."""
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)
SURF = ['aih_play', 'copspeak']   # the first five were applied by the first run


def block(text, start):
    i, depth = text.index('{', start) + 1, 1
    while depth:
        depth += text[i] == '{'
        depth -= text[i] == '}'
        i += 1
    assert text[i] == ';'
    return i + 1


for f in SURF:
    p = R + f + '_types.h'
    h = open(p, encoding='utf-8').read()
    m = re.search(r'^struct Speaker \{', h, re.M)
    assert m, f
    e = block(h, m.start())
    body = h[m.start():e]
    # private virtual lists -> the shared slot-ordered fragment
    body2, n = re.subn(r'(?:^    virtual [^\n]*\n)+', '#include "speech_speaker_virtuals.inc"' + NL, body, flags=re.M)
    assert body2.count('speech_speaker_virtuals.inc') == 1, (f, n)
    body2 = NL.join(('    ' + l if l.strip() and not l.startswith('#') else l) for l in body2.split(NL))
    new = ('/* Speech, as this surface needs it: the nested polymorphic Speaker and the two static finders */' + NL +
           'struct Speech {' + NL + body2 + NL +
           '    static Speaker *Dispatch();' + NL + '    static Speaker *Mobile(Car_tObj *carObj);' + NL + '};')
    open(p, 'w', encoding='utf-8', newline='').write(h[:m.start()] + new + h[e:])
    p = R + f + '_externs.h'
    try:
        x = open(p, encoding='utf-8').read()
        x, n = re.subn(r'^Speaker \*Speech_(?:Dispatch|Mobile)\([^\n]*\n', '', x, flags=re.M)
        open(p, 'w', encoding='utf-8', newline='').write(x)
    except FileNotFoundError:
        n = -1
    p = R + f + '.cpp'
    s = open(p, encoding='utf-8').read()
    s, n2 = re.subn(r'\bSpeech_(Dispatch|Mobile)\(', r'Speech::\1(', s)
    open(p, 'w', encoding='utf-8', newline='').write(s)
    print(f, 'externs dropped', n, 'call sites', n2)

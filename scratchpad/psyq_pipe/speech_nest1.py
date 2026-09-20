"""speech_nest1.py -- really nest Speech's classes (retail manglings Q26Speech7Speaker ...): speech_types.h moves CarBank,
LocationBank, CallSignBank, Speaker, CarBankName, DispatchSpeaker, MobileSpeaker INSIDE `struct Speech` (same relative
order) and drops every asm label that only spelled the nested mangling; speech.cpp qualifies its definitions."""
import re

R = 'C:/Temp/nfs4-decomp/recon/game/common/'
NL = chr(10)
NAMES = 'Speaker|DispatchSpeaker|MobileSpeaker|CarBank|LocationBank|CallSignBank|CarBankName'


def strip_labels(t):
    t, n = re.subn(r'\s*\n?\s*asm\("[^"]*(?:Q26Speech|__6Speech)[^"]*"\)', '', t)
    return t, n


h = open(R + 'speech_types.h', encoding='utf-8').read()
fwd = 'struct CarBankName;' + NL + 'struct MobileSpeaker;' + NL + 'struct DispatchSpeaker;' + NL + NL
assert h.count(fwd) == 1
h = h.replace(fwd, '')
a = h.index('struct CarBank {')
b = h.index('struct Speech {')
b1 = h[a:b]
h = h[:a] + h[b:]
c = h.index('/* declaration ORDER is retail evidence')
d = h.index('struct Speech_tCarDescription')
b2 = h[c:d]
h = h[:c] + h[d:]
ind = lambda t: NL.join(('    ' + l if l.strip() and not l.startswith('#') else l) for l in t.split(NL))
head = 'struct Speech {' + NL
i = h.index(head) + len(head)
h = (h[:i] + '    /* the nested classes: retail manglings are Q26Speech7Speaker, Q26Speech13MobileSpeaker, ... */' + NL +
     '    struct CarBankName;' + NL + NL + ind(b1) + ind(b2) + h[i:])
h, n = strip_labels(h)
print('speech_types.h labels dropped', n)
open(R + 'speech_types.h', 'w', encoding='utf-8', newline='').write(h)

inc = open(R + 'speech_speaker_virtuals.inc', encoding='utf-8').read()
inc, n = strip_labels(inc)
inc = inc.replace('  The asm labels carry the nested-class manglings until the classes are really nested in Speech.',
                  '  Every surface nests its Speaker in `struct Speech`, so the manglings are natural.')
print('inc labels dropped', n)
open(R + 'speech_speaker_virtuals.inc', 'w', encoding='utf-8', newline='').write(inc)

s = open(R + 'speech.cpp', encoding='utf-8').read()
s, n = re.subn(r'^[A-Za-z_ \*]+Speech_Speaker_\w+\(Speaker \*self[^\n]*\n', '', s, flags=re.M)
print('stale free-function decls dropped', n)
# definitions: `Ret X::Name(` at column 0
def fix(m):
    line = m.group(0)
    line = re.sub(r'\b(' + NAMES + r')\b(?!::)', r'Speech::\1', line.split('::')[0]) + '::' + '::'.join(line.split('::')[1:]) \
        if False else line
    return line
out = []
for line in s.split(NL):
    m = re.match(r'^((?:inline |static )?[A-Za-z_][\w \*]*?)\b(' + NAMES + r')::(~?\w+)\(', line)
    if m and not line.startswith(' '):
        ret = re.sub(r'\b(' + NAMES + r')\b', r'Speech::\1', m.group(1))
        line = ret + 'Speech::' + m.group(2) + '::' + m.group(3) + '(' + line[m.end():]
    out.append(line)
s = NL.join(out)
open(R + 'speech.cpp', 'w', encoding='utf-8', newline='').write(s)
print('ok')

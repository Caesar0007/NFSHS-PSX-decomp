"""symfix_spchevnt.py -- SPCHEVNT.C vs the retail SYM (all 53 builders were DIRTY the same way):
  * parameter types are `struct SPCHNFSType_X *` (one member `unsigned long flags`), not `unsigned long *`: the retail debug
    records of these functions live in Speech.obj's block, which defines the 14 structs;
  * retail declares `parms` BEFORE `i`."""
import re
from pathlib import Path

R = Path(__file__).resolve().parents[2].as_posix() + '/'
NL = chr(10)
p = R + 'recon/game/common/spchevnt.c'
s = open(p, encoding='utf-8').read()
a = s.index('/* Retail spchevnt.obj emits no wrapper type records.')
b = s.index('/* ---- the one true cross-TU extern')
names = re.findall(r'#define (SPCHNFSType_\w+)\s+unsigned long', s[a:b])
assert len(names) == 14, names
blk = ('/* The 14 speech-token wrappers, as the retail debug records of these functions type them (Speech.obj\'s block: each is a' + NL +
       ' * struct with the single member `unsigned long flags`; SPCHEVNT.C is C, so the tags need the typedef). */' + NL +
       ''.join('typedef struct %s { unsigned long flags; } %s;' % (n, n) + NL for n in names) + NL)
s = s[:a] + blk + s[b:]
n1 = s.count('  long i;' + NL + '  long parms [12];' + NL)
s = s.replace('  long i;' + NL + '  long parms [12];' + NL, '  long parms [12];' + NL + '  long i;' + NL)
params = set(re.findall(r'SPCHNFSType_\w+ \*(\w+)', s))
n2 = 0
for v in sorted(params, key=len, reverse=True):
    s, k = re.subn(r'\b%s\[0\]' % re.escape(v), v + '->flags', s)
    n2 += k
open(p, 'w', encoding='utf-8', newline='').write(s)
print('declaration swaps', n1, '| ->flags rewrites', n2, '| [0] left', s.count('[0]'))

#!/usr/bin/env python3
"""dialect_rewrite.py [--apply] -- make the hand-written `__asm__` blocks in recon/ assembler-
dialect-neutral (GNU as via maspsx AND SN ASPSX 2.77 accept them), byte-for-byte equivalent in
the GNU lane:
  * `$t2`-style register names -> numeric `$10` (ASPSX only knows numeric registers; cc1 itself
    only ever emits numeric ones, so this is what every retail object was assembled from)
  * `.set push` dropped / `.set pop` -> `.set reorder` + `.set at` (space forms: maspsx passes
    them through untouched exactly like it passed push/pop; gas state is restored the same way)
  * `.local X` dropped (labels and `=` aliases are file-local by default in gas; ASPSX has no
    such directive at all)
Aliases (`X = Y`) and the cert `.include` files are handled by hand (see the session notes).
Without --apply it only reports what would change."""
import re, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent))
from asmblocks import blocks, literals, REG, REGPAT, sources, ROOT
apply = '--apply' in sys.argv
changed = []
for p in sources():
    raw = p.read_bytes()
    t = raw.decode('utf-8')          # byte-preserving: UTF-8 in, UTF-8 out, newlines untouched
    if '__asm__' not in t and 'asm' not in t:
        continue
    edits = []   # (start, end, new)
    for s, e in blocks(t):
        for a, b in literals(t, s, e):
            lit = t[a:b]
            new = REGPAT.sub(lambda m: '$' + str(REG[m.group(1)]), lit)
            # directives: literals hold escaped newlines (\n), one directive per line
            lines = new.split('\\n')
            out = []
            for ln in lines:
                stripped = ln.replace('\\t', ' ').strip()
                if re.match(r'\.set\s+push$', stripped):
                    continue
                if re.match(r'\.local\s+\S+$', stripped):
                    continue
                if re.match(r'\.set\s+pop$', stripped):
                    lead = ln[:len(ln) - len(ln.lstrip())] or ln[:ln.find('.set')]
                    prefix = ln[:ln.find('.set')]
                    out.append(prefix + '.set reorder')
                    out.append(prefix + '.set at')
                    continue
                out.append(ln)
            new = '\\n'.join(out)
            if new != lit:
                edits.append((a, b, new))
    if not edits:
        continue
    nt = t
    for a, b, new in sorted(edits, reverse=True):
        nt = nt[:a] + new + nt[b:]
    # a dropped directive can leave an empty literal line like "" or "\t" -- harmless, keep
    changed.append((p.relative_to(ROOT).as_posix(), len(edits)))
    if apply:
        assert nt.encode('utf-8') != raw
        p.write_bytes(nt.encode('utf-8'))
print(('APPLIED' if apply else 'would change'), len(changed), 'files')
for f, n in changed:
    print('  %3d literals  %s' % (n, f))

#!/usr/bin/env python3
"""w48_a1_fixnl.py -- repair C string literals whose trailing \\n escape was collapsed into a
real newline by a scripted edit (the catalog's standing heredoc/backslash hazard).

Finds any line whose quote count is ODD (an unterminated literal) and whose NEXT line starts
with `";` -- i.e. the literal ran off the end -- and re-joins them with a literal backslash-n.
"""
import sys
from pathlib import Path

BS = chr(92)
p = Path(sys.argv[1])
s = p.read_text(encoding='utf-8', newline='')
nl = '\r\n' if '\r\n' in s else '\n'
lines = s.split(nl)
out = []
i = 0
fixed = 0
while i < len(lines):
    ln = lines[i]
    # an odd number of unescaped quotes => the literal is left open on this line
    q = 0
    j = 0
    while j < len(ln):
        if ln[j] == BS:
            j += 2
            continue
        if ln[j] == '"':
            q += 1
        j += 1
    if q % 2 == 1 and i + 1 < len(lines) and lines[i + 1].lstrip().startswith('";'):
        out.append(ln + BS + 'n' + lines[i + 1].lstrip())
        i += 2
        fixed += 1
        continue
    out.append(ln)
    i += 1
p.write_text(nl.join(out), encoding='utf-8', newline='')
print('fixed', fixed)
